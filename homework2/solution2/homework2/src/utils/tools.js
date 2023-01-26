function getRotationPrecomputeL(precompute_L, rotationMatrix){
	let rot = mat4Matrix2mathMatrix(rotationMatrix);
	let SA_3x3 = computeSquareMatrix_3by3(rot);
	let SA_5x5 = computeSquareMatrix_5by5(rot);

	let result = [];
	for (let i=0;i<3;i++) {
		let coeffs_1 = math.multiply(SA_3x3, [precompute_L[1][i], precompute_L[2][i], precompute_L[3][i]]);
		let coeffs_2 = math.multiply(SA_5x5, [precompute_L[4][i], precompute_L[5][i], precompute_L[6][i], precompute_L[7][i], precompute_L[8][i]]);
		result.push(mat3.fromValues(
			precompute_L[0][i], coeffs_1[0], coeffs_1[1], coeffs_1[2], coeffs_2[0], coeffs_2[1], coeffs_2[2], coeffs_2[3], coeffs_2[4]
		));
	}

	return result;
}

function computeSquareMatrix_3by3(rotationMatrix){ // 计算方阵SA(-1) 3*3 
	
	// 1、pick ni - {ni}
	let n1 = [1, 0, 0, 0]; let n2 = [0, 0, 1, 0]; let n3 = [0, 1, 0, 0];

	// 2、{P(ni)} - A  A_inverse
	let p1 = SHEval3(n1[0], n1[1], n1[2]);
	let p2 = SHEval3(n2[0], n2[1], n2[2]);
	let p3 = SHEval3(n3[0], n3[1], n3[2]);
	let A_inverse = math.inv([
		[p1[1], p1[2], p1[3]], 
		[p2[1], p2[2], p2[3]], 
		[p3[1], p3[2], p3[3]]
	]);

	// 3、用 R 旋转 ni - {R(ni)}
	let n1_rot = math.multiply(rotationMatrix, n1);
	let n2_rot = math.multiply(rotationMatrix, n2);
	let n3_rot = math.multiply(rotationMatrix, n3);
	let p1_rot = SHEval3(n1_rot._data[0], n1_rot._data[1], n1_rot._data[2]);
	let p2_rot = SHEval3(n2_rot._data[0], n2_rot._data[1], n2_rot._data[2]);
	let p3_rot = SHEval3(n3_rot._data[0], n3_rot._data[1], n3_rot._data[2]);

	// 4、R(ni) SH投影 - S
	let S = [
		[p1_rot[1], p1_rot[2], p1_rot[3]], 
		[p2_rot[1], p2_rot[2], p2_rot[3]], 
		[p3_rot[1], p3_rot[2], p3_rot[3]]
	]

	// 5、S*A_inverse
	return math.multiply(S, A_inverse);
}

function computeSquareMatrix_5by5(rotationMatrix){ // 计算方阵SA(-1) 5*5
	
	// 1、pick ni - {ni}
	let k = 1 / math.sqrt(2);
	let n1 = [1, 0, 0, 0]; let n2 = [0, 0, 1, 0]; let n3 = [k, k, 0, 0]; 
	let n4 = [k, 0, k, 0]; let n5 = [0, k, k, 0];

	// 2、{P(ni)} - A  A_inverse
	let p1 = SHEval3(n1[0], n1[1], n1[2]);
	let p2 = SHEval3(n2[0], n2[1], n2[2]);
	let p3 = SHEval3(n3[0], n3[1], n3[2]);
	let p4 = SHEval3(n4[0], n4[1], n4[2]);
	let p5 = SHEval3(n5[0], n5[1], n5[2]);
	let A_inverse = math.inv([
		[p1[4], p1[5], p1[6], p1[7], p1[8]], 
		[p2[4], p2[5], p2[6], p2[7], p2[8]], 
		[p3[4], p3[5], p3[6], p3[7], p3[8]],
		[p4[4], p4[5], p4[6], p4[7], p4[8]],
		[p5[4], p5[5], p5[6], p5[7], p5[8]]
	]);

	// 3、用 R 旋转 ni - {R(ni)}
	let n1_rot = math.multiply(rotationMatrix, n1);
	let n2_rot = math.multiply(rotationMatrix, n2);
	let n3_rot = math.multiply(rotationMatrix, n3);
	let n4_rot = math.multiply(rotationMatrix, n4);
	let n5_rot = math.multiply(rotationMatrix, n5);
	let p1_rot = SHEval3(n1_rot._data[0], n1_rot._data[1], n1_rot._data[2]);
	let p2_rot = SHEval3(n2_rot._data[0], n2_rot._data[1], n2_rot._data[2]);
	let p3_rot = SHEval3(n3_rot._data[0], n3_rot._data[1], n3_rot._data[2]);
	let p4_rot = SHEval3(n4_rot._data[0], n4_rot._data[1], n4_rot._data[2]);
	let p5_rot = SHEval3(n5_rot._data[0], n5_rot._data[1], n5_rot._data[2]);

	// 4、R(ni) SH投影 - S
	let S = [
		[p1_rot[4], p1_rot[5], p1_rot[6], p1_rot[7], p1_rot[8]], 
		[p2_rot[4], p2_rot[5], p2_rot[6], p2_rot[7], p2_rot[8]], 
		[p3_rot[4], p3_rot[5], p3_rot[6], p3_rot[7], p3_rot[8]],
		[p4_rot[4], p4_rot[5], p4_rot[6], p4_rot[7], p4_rot[8]],
		[p5_rot[4], p5_rot[5], p5_rot[6], p5_rot[7], p5_rot[8]]
	]

	// 5、S*A_inverse
	return math.multiply(S, A_inverse);

}

function mat4Matrix2mathMatrix(rotationMatrix){

	let mathMatrix = [];
	for(let i = 0; i < 4; i++){
		let r = [];
		for(let j = 0; j < 4; j++){
			r.push(rotationMatrix[i*4+j]);
		}
		mathMatrix.push(r);
	}
	return math.matrix(mathMatrix)

}

function getMat3ValueFromRGB(precomputeL){

    let colorMat3 = [];
    for(var i = 0; i<3; i++){
        colorMat3[i] = mat3.fromValues( precomputeL[0][i], precomputeL[1][i], precomputeL[2][i],
										precomputeL[3][i], precomputeL[4][i], precomputeL[5][i],
										precomputeL[6][i], precomputeL[7][i], precomputeL[8][i] ); 
	}
    return colorMat3;
}