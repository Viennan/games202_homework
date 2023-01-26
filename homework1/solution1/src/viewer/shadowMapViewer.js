class ShadowMapViewer extends Material {
    constructor(light, vertexShader, fragmentShader) {
        super(
            {'uShadowMap': { type: 'texture', value: light.fbo },}, [], vertexShader, fragmentShader, null
        )
    }
}

function buildShadowMapViewer(light) {

    // let vertexShader = await getShaderString("./src/shaders/viewShadowShader/viewShadowVertex.glsl");
    // let fragmentShader = await getShaderString("./src/shaders/viewShadowShader/viewShadowFragment.glsl");

    return new ShadowMapViewer(light, ViewShadowVertexShader, ViewShadowFragmentShader);

}