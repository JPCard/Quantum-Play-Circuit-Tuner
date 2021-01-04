extends "res://src/gameplay/gates/Gate.gd"


func _ready():
	matrix = [[complex1oversqrt2, complex1oversqrt2],
			  [complex1oversqrt2, complexNegative1oversqrt2]]
