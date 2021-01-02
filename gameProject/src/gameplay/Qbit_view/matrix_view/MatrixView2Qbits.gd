extends "res://src/gameplay/Qbit_view/matrix_view/MatrixView1Qbit.gd"


func _ready():
	pass
	#var auxComp = Complex.new()
	#auxComp.init(0.5,0.5)
	
	#updateQbitSystem([[auxComp, auxComp],[auxComp, auxComp]])


func updateQbitSystem(matrix:Array)->void:
	.updateQbitSystem(matrix)
	
	qbitSystemLabel.text += "\n\n"
	qbitSystemLabel.text += str(matrix[1][0].getReal()) + " + " + str(matrix[1][0].getImaginary()) + " i"
	qbitSystemLabel.text += "   " + str(matrix[1][1].getReal()) + " + " + str(matrix[1][1].getImaginary()) + " i"
