extends "res://src/user_interface/statesUI/StateInGameUI.gd"

func _ready():
	$TitleBannerInGame.setTitle("Modo libre")

func init(auxPrevUI: StateUI)->void:
	prevUI = auxPrevUI


