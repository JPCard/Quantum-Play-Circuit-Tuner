extends Node
class_name Complex



var real: float setget setReal, getReal
var imaginary: float setget setImaginary, getImaginary



func init(auxReal: float, auxImg: float):
	setReal(auxReal)
	setImaginary(auxImg)
	
	return self # para poder hacer new y init en la misma linea


func setReal(auxReal: float)->void:
	real = auxReal

func getReal()->float:
	return real

func setImaginary(auxImg: float)->void:
	imaginary = auxImg

func getImaginary()->float:
	return imaginary

func sumTo(complex):
	var auxReal : float = getReal() + complex.getReal()
	var auxImaginary : float = getImaginary() + complex.getImaginary()
	
	var auxComplex= load("res://src/gameplay/Complex.gd").new()
	auxComplex.init(auxReal, auxImaginary)
	
	return auxComplex

func multiplyTo(complex):
	
	
	var auxReal : float = getReal() * complex.getReal() - getImaginary() * complex.getImaginary()
	var auxImaginary : float = getReal() * complex.getImaginary() + getImaginary() * complex.getReal()
	
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

func equals(complex)->bool:
	if(complex == null):
		return false
	if(self == complex):
		return true
	elif(abs(getReal() - complex.getReal()) < GameGlobals.NUMERIC_TOLERANCE  && abs(getImaginary() - complex.getImaginary()) < GameGlobals.NUMERIC_TOLERANCE):
		# corrige redondeos de la computadora por operar con numeros irracionales
		return true
	else:
		return false
	


# retorna el argumento de este numero complejo
# Pre: no permite el complejo nulo como parametro
func argument()->float:
	return atan2(getImaginary(), getReal())

func absoluteValue()->float:
	return sqrt(probability())

func probability()->float:
	return pow(getReal(), 2) + pow(getImaginary(), 2)

