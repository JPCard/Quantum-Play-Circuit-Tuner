extends "res://src/user_interface/statesUI/StateInGameUI.gd"


func init(auxPrevUI: StateUI, levelID: int)->void:
	prevUI = auxPrevUI
	$TitleBannerInGame.setTitle("Nivel  " + str(levelID + 1))
	
	var initialStateMatrix = GameDataExpert.obtainInitialStateMatrix(levelID)
	var goalStateMatrix = GameDataExpert.obtainGoalStateMatrix(levelID)
	
	updateCurrentQbitViews(initialStateMatrix)
	$Circuit.setInitialQbitState(initialStateMatrix)
	
	updateGoalQbitViews(goalStateMatrix)
	$Circuit.setGoalQbitState(goalStateMatrix)


func win()->void:
	# mostrar un popup que te permita ir al siguiente nivel o volver al menu de seleccion de niveles
	print("ganaste")


func updateCurrentQbitViews(qbitStateMatrix: Array)->void:
	$QbitViewClassic2Qbits.updateCurrentQbitSystem(qbitStateMatrix)


func updateGoalQbitViews(qbitStateMatrix: Array)->void:
	$QbitViewClassic2Qbits.updateGoalQbitSystem(qbitStateMatrix)
