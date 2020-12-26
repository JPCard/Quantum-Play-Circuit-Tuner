extends "res://src/user_interface/StateUI.gd"

onready var levelSelectUI = loadStateUI("StateLevelSelectUI")

func _ready():
	levelSelectUI.init(self)



func toLevelSelectUI()->void:
	get_parent().call_deferred("add_child",levelSelectUI)
	get_parent().call_deferred("remove_child",self)


func backButtonPressed()->void:
	get_tree().quit() # cerrar el juego
