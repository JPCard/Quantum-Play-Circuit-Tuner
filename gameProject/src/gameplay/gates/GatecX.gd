extends "res://src/gameplay/gates/Gate.gd"




func _ready():
	matrix = [[complex1, complex0, complex0, complex0],
			  [complex0, complex1, complex0, complex0],
			  [complex0, complex0, complex0, complex1],
			  [complex0, complex0, complex1, complex0]]


