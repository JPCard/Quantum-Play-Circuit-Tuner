extends "res://src/user_interface/statesUI/StateInGameUI.gd"


onready var qbitViewClassic1Qbit = $QbitViewClassic1Qbit
onready var circuit = $Circuit
onready var popupLevelCompleted = $PopupLevelCompleted

var levelID: int
var inGameClassic2QbitsUI: StateUI
var pendingLoadNextLevel2Qbits: bool = false

func init(auxPrevUI: StateUI, auxInGameClassic2QbitsUI: StateUI, auxLevelID: int, isCurrentLevel:bool)->void:
	
	prevUI = auxPrevUI
	inGameClassic2QbitsUI = auxInGameClassic2QbitsUI
	levelID = auxLevelID
	
	$TitleBannerInGame.setTitle("Nivel  " + str(auxLevelID + 1))
	
	var initialStateMatrix = GameDataExpert.obtainInitialStateMatrix(auxLevelID)
	var goalStateMatrix = GameDataExpert.obtainGoalStateMatrix(auxLevelID)
	
	updateCurrentQbitViews(initialStateMatrix)
	$Circuit.setInitialQbitState(initialStateMatrix)
	
	updateGoalQbitViews(goalStateMatrix)
	$Circuit.setGoalQbitState(goalStateMatrix)
	
	if(!isCurrentLevel):
		pendingLoadNextLevel2Qbits = true
	elif(levelID + 1 < GameDataExpert.obtainLevelCount() && !GameDataExpert.is1QbitLevel(levelID + 1)):
		# prepara de antemano el nivel siguiente si es de 2 qbits
		inGameClassic2QbitsUI.init(prevUI, self, levelID + 1, false) # no es el nivel actual sino que es el siguiente



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


func updateCurrentQbitViews(qbitStateMatrix: Array)->void:
	$QbitViewClassic1Qbit.updateCurrentQbitSystem(qbitStateMatrix)


func updateGoalQbitViews(qbitStateMatrix: Array)->void:
	$QbitViewClassic1Qbit.updateGoalQbitSystem(qbitStateMatrix)


# cada vez que se entra a este menu
func _on_Circuit_tree_entered():
	resetUI()


func resetUI():
	$Circuit.resetGateHolders()
	$PopupLevelCompleted.hide()


func toNextLevel()->void:
	if(GameDataExpert.is1QbitLevel(levelID + 1)):
		init(prevUI, inGameClassic2QbitsUI, levelID + 1, true)
	else:
		if(pendingLoadNextLevel2Qbits):
			inGameClassic2QbitsUI.init(prevUI, self, levelID + 1, true) # carga el nivel pendiente
		toInGameClassic2QbitsUI()
	
	_on_Circuit_tree_entered()


# Pre: el nivel ya estaba inicializado porque se detecto que iba a ser de 2 qbits
func toInGameClassic2QbitsUI()->void:
	get_parent().call_deferred("add_child",inGameClassic2QbitsUI)
	get_parent().call_deferred("remove_child",self)
