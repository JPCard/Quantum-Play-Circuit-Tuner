extends Node

var complex0 = Complex.new().init(0,0)
var complex1 = Complex.new().init(1,0)
var dim2Identity: Array = [[complex1, complex0], [complex0, complex1]]

func _init():
	pass
	#tensorMultiplyComplexMatrices([[1,0],[1,0]],[[0,1],[1,0]])


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


# Pre: - mat1 != null y mat2 != null.  mat1 y mat2 son arreglos de arreglos (matrices)
#      - n1, n2, m1, m2 > 0 -> matrices validas
#
# Returns -> una matriz resultado de la multiplicacion de dimension (n1*n2)*(m1*m2)
func tensorMultiplyComplexMatrices(mat1:Array, mat2:Array)->Array:
	
	var res: Array
	var n1 : int = mat1.size()
	var m1 : int = mat1[0].size() 
	var n2 : int = mat2.size()
	var m2 : int = mat2[0].size()
	
	
	var auxComplex : Complex
	var complex0 : Complex = Complex.new().init(0,0)
	
	res.resize(n1 * n2)
	for i in range(n1 * n2):
		res[i] = []
		res[i].resize(m1 * m2)
	
	for i1 in range(n1):
		for j1 in range(m1):
			for i2 in range(n2):
				for j2 in range(m2):
					#res[i1 * n2 + i2][j1 * m2 + j2] = mat1[i1][j1] * mat2[i2][j2]
					res[i1 * n2 + i2][j1 * m2 + j2] = mat1[i1][j1].multiplyTo(mat2[i2][j2])
	
	
	return res

func tensorPreMultiplyDim2IdentityToComplexMatrix(mat: Array):
	return tensorMultiplyComplexMatrices(dim2Identity, mat)




func tensorPostMultiplyDim2IdentityToComplexMatrix(mat: Array):
	return tensorMultiplyComplexMatrices(mat, dim2Identity)
