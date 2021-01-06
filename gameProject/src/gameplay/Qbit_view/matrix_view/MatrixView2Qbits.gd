extends "res://src/gameplay/Qbit_view/matrix_view/MatrixView1Qbit.gd"


func _ready():
	pass
	#var auxComp = Complex.new()
	#auxComp.init(0.5,0.5)
	
	#updateQbitSystem([[auxComp, auxComp],[auxComp, auxComp]])


func updateQbitSystem(matrix:Array)->void:
	.updateQbitSystem(matrix)
	
	$QbitSystemLabel.text += "\n\n"
	$QbitSystemLabel.text = "%2.1f + %2.1f" % [matrix[0][2].getReal(), matrix[0][2].getImaginary()] + " i" 
	$QbitSystemLabel.text += "\n\n" + "%2.1f + %2.1f" % [matrix[0][3].getReal(), matrix[0][3].getImaginary()] + " i"
