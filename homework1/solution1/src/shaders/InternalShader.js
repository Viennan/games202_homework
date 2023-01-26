const LightCubeVertexShader = `
attribute vec3 aVertexPosition;

uniform mat4 uModelMatrix;
uniform mat4 uViewMatrix;
uniform mat4 uProjectionMatrix;


void main(void) {

  gl_Position = uProjectionMatrix * uViewMatrix * uModelMatrix * vec4(aVertexPosition, 1.0);

}
`;

const LightCubeFragmentShader = `
#ifdef GL_ES
precision mediump float;
#endif

uniform float uLigIntensity;
uniform vec3 uLightColor;

void main(void) {

  gl_FragColor = vec4(uLightColor, 1.0);
}
`;

const ViewShadowVertexShader = `
attribute vec3 aVertexPosition;
attribute vec2 aTextureCoord;

uniform mat4 uModelMatrix;
uniform mat4 uViewMatrix;
uniform mat4 uProjectionMatrix;

varying highp vec2 vTextureCoord;

void main(void) {
  vTextureCoord = aTextureCoord;
  gl_Position = vec4(aVertexPosition, 1.0);
}
`;

const ViewShadowFragmentShader = `
#ifdef GL_ES
precision mediump float;
#endif

uniform sampler2D uShadowMap;
uniform vec3 uLightPos;
uniform vec3 uCameraPos;

varying highp vec2 vTextureCoord;

float unpack(vec4 rgbaDepth) {
    const vec4 bitShift = vec4(1.0, 1.0/256.0, 1.0/(256.0*256.0), 1.0/(256.0*256.0*256.0));
    return dot(rgbaDepth, bitShift);
}

void main(){
  float z = unpack(texture2D(uShadowMap, vTextureCoord));
  gl_FragColor = vec4(z, z, z, 1.0);
}
`;