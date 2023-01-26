class EnvDiffuseMaterial extends Material {

    constructor(vertexShader, fragmentShader) {
        super({
            "uPrecomputeLR": {type: "updatedInRealTime", value: null},
            "uPrecomputeLG": {type: "updatedInRealTime", value: null},
            "uPrecomputeLB": {type: "updatedInRealTime", value: null},
            'uMoveWithCamera': { type: 'updatedInRealTime', value: null }
        }, ["aPrecomputeLT"], vertexShader, fragmentShader, null);
    }
}

async function buildEnvDiffuseMaterial(vertexPath, fragmentPath) {


    let vertexShader = await getShaderString(vertexPath);
    let fragmentShader = await getShaderString(fragmentPath);

    return new EnvDiffuseMaterial(vertexShader, fragmentShader);

}