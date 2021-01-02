extends Node
class_name Complex

var real: float setget setReal, getReal
var imaginary: float setget setImaginary, getImaginary



func init(auxReal: float, auxImg: float)->void:
	setReal(auxReal)
	setImaginary(auxImg)


func setReal(auxReal: float)->void:
	real = auxReal

func getReal()->float:
	return real

func setImaginary(auxImg: float)->void:
	imaginary = auxImg

func getImaginary()->float:
	return imaginary

func multiplicateTo(complex):
	
	
	var auxReal : float = getReal() * complex.getReal() - getImaginary() * complex.getImaginary()
	var auxImaginary : float = getReal() * complex.getImaginary + getImaginary() * complex.getReal()
	
	var auxComplex= load("res://src/gameplay/Complex.gd").new()
	auxComplex.init(auxReal, auxImaginary)
	
	return auxComplex


# Pre: complex != 0
func divideTo(complex):
	var divisor : float = pow(complex.getReal(), 2) + pow(complex.getImaginary(), 2)
	
	var auxReal : float = (getReal() * complex.getReal() + getImaginary() * complex.getImaginary()) / divisor
	var auxImaginary : float = (getImaginary() * complex.getReal() - getReal() * complex.getImaginary) / divisor
	
	var auxComplex= load("res://src/gameplay/Complex.gd").new()
	auxComplex.init(auxReal, auxImaginary)
	
	return auxComplex

