extends Control

signal level_select_bt_pressed
signal next_level_bt_pressed

onready var nextLevelBt = $HBoxContainer/NextLevelBt

func _ready():
	pass # Replace with function body.



func _on_LevelSelectBt_pressed()->void:
	emit_signal("level_select_bt_pressed")


func _on_NextLevelBt_pressed()->void:
	emit_signal("next_level_bt_pressed")



func hideNextLevelBt()->void:
	nextLevelBt.hide()


func showNextLevelBt()->void:
	nextLevelBt.show()


