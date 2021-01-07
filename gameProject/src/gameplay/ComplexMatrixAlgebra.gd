extends Node




# Pre: - mat1 != null y mat2 != null.  mat1 y mat2 son arreglos de arreglos (matrices)
#      - n1, n2, m1, m2 > 0 -> matrices validas
#      - m1 = n2 -> condicion de multiplicacion de matrices
#
# Returns -> una matriz resultado de la multiplicacion de dimension n1*m2
func multiplyComplexMatrices(mat1:Array, mat2:Array)->Array:
	
	var res: Array
	var n1 : int = mat1.size()
	var m1 : int = mat1[0].size() # m1 = n2
	var m2 : int = mat2[0].size()
	res.resize(n1)
	
	var auxComplex : Complex
	var complex0 : Complex = Complex.new().init(0,0)
	
	for i in range(n1):
		res[i] = []
		res[i].resize(m2)
		for j in range(m2):
			auxComplex = complex0
			for k in range(m1):
				auxComplex = auxComplex.sumTo(mat1[i][k].multiplyTo(mat2[k][j]))
			res[i][j] = auxComplex
	
	
	return res



