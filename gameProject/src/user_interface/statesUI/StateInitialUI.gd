extends "res://src/user_interface/statesUI/StateUI.gd"

onready var levelSelectUI: StateUI = loadStateUI("StateLevelSelectUI")
onready var inGameClassic1QbitUI: StateUI = loadStateUI("StateInGameClassic1QbitUI")
onready var inGameClassic2QbitsUI: StateUI = loadStateUI("StateInGameClassic2QbitsUI")
onready var inGameFreeUI: StateUI = loadStateUI("StateInGameFreeUI")

var currentLevel1Qbit: bool
var currentLevelID: int = -999

func _ready():
	levelSelectUI.init(self, inGameClassic1QbitUI, inGameClassic2QbitsUI)
	updateCurrentLevel()
	inGameFreeUI.init(self)
	connect("tree_entered", self, "menuOpened")


func updateCurrentLevel()->void:
	var auxCurrentLevelID = GameDataExpert.obtainCurrentLevelID()
	
	if(currentLevelID != auxCurrentLevelID):
		currentLevelID = auxCurrentLevelID
		currentLevel1Qbit = GameDataExpert.is1QbitLevel(currentLevelID)
		
		if(currentLevel1Qbit):
			inGameClassic1QbitUI.init(levelSelectUI, inGameClassic2QbitsUI, currentLevelID, true)
		else:
			inGameClassic2QbitsUI.init(levelSelectUI, inGameClassic1QbitUI, currentLevelID, true)
	


func toLevelSelectUI()->void:
	get_parent().call_deferred("add_child",levelSelectUI)
	get_parent().call_deferred("remove_child",self)


func toInGameFreeUI()->void:
	get_parent().call_deferred("add_child",inGameFreeUI)
	get_parent().call_deferred("remove_child",self)


func toInGameClassicUI()->void:
	
	if(currentLevel1Qbit):
		get_parent().call_deferred("add_child",inGameClassic1QbitUI)
	else:
		get_parent().call_deferred("add_child",inGameClassic2QbitsUI)
	
	get_parent().call_deferred("remove_child",self)

func backButtonPressed()->void:
	get_tree().quit() # cerrar el juego


# se llama cada vez que se entra a este menu
func menuOpened():
	updateCurrentLevel()
