extends "res://src/user_interface/statesUI/StateUI.gd"

onready var levelSelectUI: StateUI = loadStateUI("StateLevelSelectUI")
onready var inGameClassicUI: StateUI = loadStateUI("StateInGameClassic1QbitUI")
onready var inGameFreeUI: StateUI = loadStateUI("StateInGameFreeUI")


func _ready():
	levelSelectUI.init(self)
	inGameClassicUI.init(levelSelectUI, GameDataExpert.obtainCurrentLevelID())
	inGameFreeUI.init(self)


func toLevelSelectUI()->void:
	get_parent().call_deferred("add_child",levelSelectUI)
	get_parent().call_deferred("remove_child",self)


func toInGameFreeUI()->void:
	get_parent().call_deferred("add_child",inGameFreeUI)
	get_parent().call_deferred("remove_child",self)


func toInGameClassicUI()->void:
	get_parent().call_deferred("add_child",inGameClassicUI)
	get_parent().call_deferred("remove_child",self)

func backButtonPressed()->void:
	get_tree().quit() # cerrar el juego

