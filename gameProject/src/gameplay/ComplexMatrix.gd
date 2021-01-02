extends Node


# Pre: - mat1 != null y mat2 != null.  mat1 y mat2 son arreglos de arreglos (matrices)
#      - n1, n2, m1, m2 > 0 -> matrices validas
#      - n1 = n2 = m1 = m2 -> son matrices cuadradas de la misma dimension
func multiplySquareMatrices(mat1:Array, mat2:Array)->Array:
	
	var res: Array
	var n : int = mat1.size()
	
	res.resize(n)
	
	for i in range(n):
		res[i].resize(n)
		for j in range(n):
			res[i][j] = 0
			for k in range(n):
				res[i][j] += mat1[i][k] * mat2[k][j]
	
	
	return res


