extends Node2D


onready var qbitSystemLabel : Label = $QbitSystemLabel

func _ready():
	pass
	#$BackgroundSprite.hide()
	#var auxComp = Complex.new()
	#auxComp.init(0.5,0.5)
	#updateQbitSystem([[auxComp, auxComp],[auxComp, auxComp]])


func updateQbitSystem(matrix:Array)->void:
	
	$QbitSystemLabel.text = "%2.1f + %2.1f" % [roundOutput(matrix[0][0].getReal()), roundOutput(matrix[0][0].getImaginary())] + " i" 
	$QbitSystemLabel.text += "\n\n" + "%2.1f + %2.1f" % [roundOutput(matrix[0][1].getReal()), roundOutput(matrix[0][1].getImaginary())] + " i"


func roundOutput(number: float)->float:
	return stepify(number,0.1)
	
