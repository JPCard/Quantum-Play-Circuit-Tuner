extends Node2D


onready var qbitSystemLabel : Label = $QbitSystemLabel

func _ready():
	$BackgroundSprite.hide()
	#var auxComp = Complex.new()
	#auxComp.init(0.5,0.5)
	#updateQbitSystem([[auxComp, auxComp],[auxComp, auxComp]])


func updateQbitSystem(matrix:Array)->void:
	
	qbitSystemLabel.text = str(matrix[0][0].getReal()) + " + " + str(matrix[0][0].getImaginary()) + " i"
	qbitSystemLabel.text += "   " + str(matrix[0][1].getReal()) + " + " + str(matrix[0][1].getImaginary()) + " i"



