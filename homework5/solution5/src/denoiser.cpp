#include "denoiser.h"

Denoiser::Denoiser() : m_useTemportal(false) {}

void Denoiser::Reprojection(const FrameInfo &frameInfo) {
    int height = m_accColor.m_height;
    int width = m_accColor.m_width;
    Matrix4x4 preWorldToScreen =
        m_preFrameInfo.m_matrix[m_preFrameInfo.m_matrix.size() - 1];
    Matrix4x4 preWorldToCamera =
        m_preFrameInfo.m_matrix[m_preFrameInfo.m_matrix.size() - 2];

    std::vector<Matrix4x4> curr_model2world_inv;
    for (int i=0;i<frameInfo.m_matrix.size()-2;++i) {
        curr_model2world_inv.push_back(Inverse(frameInfo.m_matrix[i]));
    }
#pragma omp parallel for
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // TODO: Reproject
            m_valid(x, y) = false;
            m_misc(x, y) = Float3(0.f);

            auto pos = frameInfo.m_position(x, y);
            auto currWorldToScreen = frameInfo.m_matrix[frameInfo.m_matrix.size()-1];
            auto objId = int(frameInfo.m_id(x, y));
            auto preModelToWorld = m_preFrameInfo.m_matrix[objId];
            auto world2prescreen = preWorldToScreen * preModelToWorld * curr_model2world_inv[objId];
            auto preScreen = world2prescreen(pos, Float3::Point);
            if (preScreen.z == 0.0f) {
                continue;
            }
            int preX = preScreen.x / preScreen.z, preY = preScreen.y / preScreen.z;
            if (preX < 0 || preX >= width || preY < 0 || preY >= height) {
                continue;
            }
            if (objId != int(m_preFrameInfo.m_id(preX, preY))) {
                continue;
            }
            m_valid(x, y) = true;
            m_misc(x, y) = m_accColor(preX, preY);
        }
    }
    std::swap(m_misc, m_accColor);
}

void Denoiser::TemporalAccumulation(const Buffer2D<Float3> &curFilteredColor) {
    int height = m_accColor.m_height;
    int width = m_accColor.m_width;
    int kernelRadius = 3;
#pragma omp parallel for
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // TODO: Temporal clamp
            Float3 sumX = 0.0f, sumX2 = 0.0f;
            int x_min = std::max(0, x - kernelRadius), x_max = std::min(width, x + kernelRadius);
            int y_min = std::max(0, y - kernelRadius), y_max = std::min(height, y + kernelRadius);
            for (int fy = y_min; fy < y_max; ++fy) {
                for (int fx = x_min; fx < x_max; ++fx) {
                    sumX += curFilteredColor(fx, fy);
                    sumX2 += Sqr(curFilteredColor(fx, fy));
                }
            }
            auto total = float((x_max-x_min)*(y_max-y_min));
            auto EX = sumX / total, EX2 = sumX2 / total;
            auto o = SafeSqrt(EX2 - Sqr(EX));

            auto color = Clamp(m_accColor(x, y), EX - o * m_colorBoxK, EX + o * m_colorBoxK);
            // TODO: Exponential moving average
            float alpha = m_valid(x, y) ? m_alpha: 1.0;
            m_misc(x, y) = Lerp(color, curFilteredColor(x, y), alpha);
        }
    }
    std::swap(m_misc, m_accColor);
}

Buffer2D<Float3> Denoiser::Filter(const FrameInfo &frameInfo) {
    int height = frameInfo.m_beauty.m_height;
    int width = frameInfo.m_beauty.m_width;
    Buffer2D<Float3> filteredImage = CreateBuffer2D<Float3>(width, height);
    constexpr int kernelRadius = 16;

    // double op = 3.0;
    // double oc = 0.1;`
    // double on = M_PI / 180.0 * 5.0;
    // double od = cos(M_PI / 180.0 * 5.0);

    float op_i = 1.0 / (m_sigmaCoord*m_sigmaCoord);
    float oc_i = 1.0 / (m_sigmaColor*m_sigmaColor);
    float on_i = 1.0 / (m_sigmaNormal*m_sigmaNormal);
    float od_i = 1.0 / (m_sigmaPlane*m_sigmaPlane);

#pragma omp parallel for
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // TODO: Joint bilateral filter
            // filteredImage(x, y) = frameInfo.m_beauty(x, y);
            int _x_min = x-kernelRadius, _x_max = x+kernelRadius;
            int _y_min = y-kernelRadius, _y_max = y+kernelRadius;
            auto fv = Float3(0.0f);
            auto weight_sum = 0.0f;
            auto c_ref = frameInfo.m_beauty(x, y);
            auto n_ref = frameInfo.m_normal(x, y);
            auto pos_ref = frameInfo.m_position(x, y);
            for (int _fy = _y_min; _fy<=_y_max; ++_fy) {
                for (int _fx = _x_min; _fx<=_x_max; ++_fx) {
                    int fx = std::max(0, std::min(_fx, width-1));
                    int fy = std::max(0, std::min(_fy, height-1));

                    auto w_p = std::exp(-0.5f * op_i * ((_fy-y) * (_fy-y) + (_fx-x)*(_fx-x)));

                    auto c = frameInfo.m_beauty(fx, fy);
                    auto diff_c = c - c_ref;
                    auto w_c = std::exp(-0.5f * oc_i * SqrLength(diff_c));

                    auto diff_n = SafeAcos(Dot(n_ref, frameInfo.m_normal(fx, fy)));
                    auto w_n = std::exp(-0.5f * on_i * diff_n * diff_n);

                    auto w_d = 1.0f;
                    auto offset = frameInfo.m_position(fx, fy) - pos_ref;
                    if (auto dis = Length(offset) > 0.0f) {
                        auto diff_d = Dot(n_ref, offset / dis);
                        w_d = std::exp(-0.5f * od_i * diff_d * diff_d);
                    }
                    
                    auto w = w_p * w_c * w_n * w_d;
                    fv += c * w;
                    weight_sum += w;
                }
            }
            filteredImage(x, y) = weight_sum == 0.0f ? c_ref : (fv / weight_sum);
        }
    }

    return filteredImage;
}

void Denoiser::Init(const FrameInfo &frameInfo, const Buffer2D<Float3> &filteredColor) {
    m_accColor.Copy(filteredColor);
    int height = m_accColor.m_height;
    int width = m_accColor.m_width;
    m_misc = CreateBuffer2D<Float3>(width, height);
    m_valid = CreateBuffer2D<bool>(width, height);
}

void Denoiser::Maintain(const FrameInfo &frameInfo) { m_preFrameInfo = frameInfo; }

Buffer2D<Float3> Denoiser::ProcessFrame(const FrameInfo &frameInfo) {
    // Filter current frame
    Buffer2D<Float3> filteredColor;
    filteredColor = Filter(frameInfo);

    // Reproject previous frame color to current
    if (m_useTemportal) {
        // init corresponding member
        Reprojection(frameInfo);
        TemporalAccumulation(filteredColor);
    } else {
        Init(frameInfo, filteredColor);
    }

    // Maintain
    Maintain(frameInfo);
    if (!m_useTemportal) {
        m_useTemportal = true;
    }
    return m_accColor;
}
