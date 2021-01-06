extends "res://src/user_interface/statesUI/StateUI.gd"



const COUNTRY_COUNT_X: int = 3
const BT_SEPARATION_X: int = 250

const LevelBtType = preload("res://src/user_interface/LevelBt.gd")
const LevelBtFactory = preload("res://src/user_interface/LevelBtFactory.gd")

var inGameClassic1QbitUI: StateUI
var inGameClassic2QbitsUI: StateUI

var vBoxContainer: VBoxContainer 
var initialUI: StateUI

var levelBts: Array = []


func _ready():
	#yield(get_tree(), "idle_frame") #espera a que se terminen de agregar los botones y se recalcule el tamaño del ScrollContainer
	$ScrollContainer.scroll_vertical = GameDataExpert.obtainLevelListScroll()
	$TitleBanner.setTitle("Niveles")


func init(prevUI: StateUI, auxInGameClassic1QbitUI: StateUI, auxInGameClassic2QbitsUI: StateUI)->void:
	initialUI = prevUI
	inGameClassic1QbitUI = auxInGameClassic1QbitUI
	inGameClassic2QbitsUI = auxInGameClassic2QbitsUI
	
	vBoxContainer = $ScrollContainer/VBoxContainer
	
	var levelCount: int = GameDataExpert.obtainLevelCount()
	
	levelBts.resize(levelCount)
	
	var rowCount: int
	# warning-ignore:integer_division
	rowCount = 1 + (levelCount - 1) / COUNTRY_COUNT_X 
	#print(rowCount)
	# Importante: Esta division tiene que ser de enteros pues se debe truncar. Valido para cualquier country_count_x
	
	
	
	var maxUnlockedlevelID: int = GameDataExpert.obtainMaxUnlockedLevelID()
	
	
	createBlankRow() # Se deja espacio
	
	var i: int = 0
	while (i < rowCount - 1):
		createLevelBtRow(i, COUNTRY_COUNT_X, maxUnlockedlevelID)
		i += 1
	
	#sale con i = rowCount - 1
	createLevelBtRow(i, levelCount - i*COUNTRY_COUNT_X, maxUnlockedlevelID) #por si levelCount mod COUNTRY_COUNT_X != 0
	
	createBlankRow() # Se deja espacio
	
	
	


func createLevelBtRow(rowNumber: int, levelBtInRow: int, maxUnlockedlevelID: int)->void:
	var auxHBoxContainer: HBoxContainer = createHBoxContainer()
	var auxLevelBt: LevelBtType
	var levelID: int
	var unlocked: bool
	
	#print(vBoxContainer)
	for j in range(levelBtInRow):
		
		levelID = rowNumber*COUNTRY_COUNT_X + j
		unlocked = levelID <= maxUnlockedlevelID
		
		if (unlocked):
			# unlocked
			if(GameDataExpert.obtainLevelCompletionState(levelID)):
				# completed
				auxLevelBt = LevelBtFactory.createCompletedLevelBt(levelID)
			else:
				# !completed
				auxLevelBt = LevelBtFactory.createUnlockedLevelBt(levelID)
		else:
			# locked
			auxLevelBt = LevelBtFactory.createLockedLevelBt(levelID)
		
		
		if unlocked:
			auxLevelBt.connect("pressed", self, "toInGameClassicUI",[auxLevelBt.getLevelID()])
		
		levelBts[levelID] = auxLevelBt
		
		auxHBoxContainer.call_deferred("add_child",auxLevelBt)


# Pre: solo llamar sobre botones que estaban lockeados
func setLevelBtUnlocked(levelID: int)->void:
	var levelBt: LevelBt = levelBts[levelID]
	LevelBtFactory.setUnlockedTextures(levelBt)
	levelBt.setUnlocked(true)
	
	# para que al tocar te lleve al proximo nivel
	levelBt.connect("pressed", self, "toInGameClassicUI",[levelBt.getLevelID()])


# Pre: solo llamar sobre botones que estaban unlocked
func setLevelBtCompleted(levelID: int)->void:
	var levelBt: LevelBt = levelBts[levelID]
	LevelBtFactory.setCompletedTextures(levelBt)
	levelBt.setCompleted(true)


func createBlankRow()->void:
	var auxHBoxContainer: HBoxContainer = createHBoxContainer()
	var blankSpace:ColorRect = ColorRect.new()
	blankSpace.rect_size = Vector2(1870,200)
	auxHBoxContainer.call_deferred("add_child", blankSpace)
	blankSpace.mouse_filter = Control.MOUSE_FILTER_IGNORE


func createHBoxContainer()->HBoxContainer:
	var hBoxContainer: HBoxContainer = HBoxContainer.new()
	hBoxContainer.set("custom_constants/separation", BT_SEPARATION_X)
	vBoxContainer.call_deferred("add_child", hBoxContainer)
	hBoxContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	return hBoxContainer


func toInGameClassicUI(levelID: int):
	if(GameDataExpert.is1QbitLevel(levelID)):
		inGameClassic1QbitUI.init(self, inGameClassic2QbitsUI, levelID)
		get_parent().call_deferred("add_child",inGameClassic1QbitUI)
	else:
		inGameClassic2QbitsUI.init(self,levelID)
		get_parent().call_deferred("add_child",inGameClassic2QbitsUI)
	
	get_parent().call_deferred("remove_child",self)

func backButtonPressed()->void:
	get_parent().call_deferred("add_child",initialUI)
	get_parent().call_deferred("remove_child",self)
