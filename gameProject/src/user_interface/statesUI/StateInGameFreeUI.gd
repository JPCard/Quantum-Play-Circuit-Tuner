extends "res://src/user_interface/statesUI/StateInGameUI.gd"

func _ready():
	$Circuit2Qbits.setClassicMode(false)
	$TitleBannerInGame.setTitle("Modo libre")

func init(auxPrevUI: StateUI)->void:
	prevUI = auxPrevUI
	
	var initialStateMatrix = [[Complex.new().init(1,0), Complex.new().init(0,0), Complex.new().init(1,0), Complex.new().init(0,0)]]
	
	updateCurrentQbitViews(initialStateMatrix)
	$Circuit2Qbits.setInitialQbitState(initialStateMatrix)
	


func updateCurrentQbitViews(qbitStateMatrix: Array)->void:
	$QbitViewFree.updateCurrentQbitSystem(qbitStateMatrix)


