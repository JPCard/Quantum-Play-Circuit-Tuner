extends "res://src/user_interface/statesUI/StateInGameUI.gd"


onready var popupLevelCompleted = $PopupLevelCompleted


var levelID: int
var inGameClassic1QbitUI: StateUI

func _ready():
	$Circuit2Qbits.setClassicMode(true)

func init(auxPrevUI: StateUI, auxInGameClassic1QbitUI: StateUI, auxLevelID: int)->void:
	prevUI = auxPrevUI
	inGameClassic1QbitUI = auxInGameClassic1QbitUI
	levelID = auxLevelID
	
	
	$TitleBannerInGame.setTitle("Nivel  " + str(levelID + 1))
	
	var initialStateMatrices = GameDataExpert.obtainInitialStateMatrix(levelID)
	var initialStateMatrix1 = initialStateMatrices[0]
	var initialStateMatrix2 = initialStateMatrices[1]
	
	var goalStateMatrices = GameDataExpert.obtainGoalStateMatrix(levelID)
	var goalStateMatrix1 = goalStateMatrices[0]
	var goalStateMatrix2 = goalStateMatrices[1]
	
	updateCurrentQbitViews(initialStateMatrix1, initialStateMatrix2)
	$Circuit2Qbits.setInitialQbitStates(initialStateMatrix1, initialStateMatrix2)
	
	updateGoalQbitViews(goalStateMatrix1, goalStateMatrix2)
	$Circuit2Qbits.setGoalQbitStates(goalStateMatrix1, goalStateMatrix2)
	
	
	# prepara de antemano el nivel siguiente si es de 1 qbit
	if(levelID + 1 < GameDataExpert.obtainLevelCount() && GameDataExpert.is1QbitLevel(levelID + 1)):
		inGameClassic1QbitUI.init(prevUI, self, levelID + 1)
	
	



func win()->void:
	# mostrar un popup que te permita ir al siguiente nivel o volver al menu de seleccion de niveles
	#print("ganaste")
	
	
	
	if(levelID < GameDataExpert.obtainLevelCount() - 1):
		# hay nivel proximo -> habilitar boton nivel siguiente
		popupLevelCompleted.showNextLevelBt()
		Persistence.saveCurrentLevelID(levelID + 1) # el actual siempre es el siguiente al ultimo que se completo
		
		if(GameDataExpert.obtainMaxCompletedLevelID() < levelID):
			Persistence.saveMaxCompletedLevelID(levelID)
			prevUI.setLevelBtCompleted(levelID)
			prevUI.setLevelBtUnlocked(levelID + 1)
		
		
		
	else: # no hay nivel proximo -> deshabilitar boton nivel siguiente
		popupLevelCompleted.hideNextLevelBt()
		
		
		if(GameDataExpert.obtainMaxCompletedLevelID() < levelID):
			Persistence.saveMaxCompletedLevelID(levelID)
			prevUI.setLevelBtCompleted(levelID)
	
	
	popupLevelCompleted.show()


func updateCurrentQbitViews(qbitStateMatrix1: Array, qbitStateMatrix2: Array)->void:
	$QbitViewClassic2Qbits.updateCurrentQbitSystem(qbitStateMatrix1, qbitStateMatrix2)


func updateGoalQbitViews(qbitStateMatrix1: Array, qbitStateMatrix2: Array)->void:
	$QbitViewClassic2Qbits.updateGoalQbitSystem(qbitStateMatrix1, qbitStateMatrix2)



# cada vez que se entra a este menu
func _on_Circuit2Qbits_tree_entered():
	$Circuit2Qbits.resetGateHolders()
	$PopupLevelCompleted.hide()



func toNextLevel()->void:
	if(!GameDataExpert.is1QbitLevel(levelID + 1)):
		init(prevUI, inGameClassic1QbitUI, levelID + 1)
	else:
		toInGameClassic1QbitUI()
	
	_on_Circuit2Qbits_tree_entered()


# Pre: el nivel ya estaba inicializado porque se detecto que iba a ser de 1 qbit
func toInGameClassic1QbitUI()->void:
	get_parent().call_deferred("add_child",inGameClassic1QbitUI)
	get_parent().call_deferred("remove_child",self)

