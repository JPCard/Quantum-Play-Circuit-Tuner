extends "res://src/user_interface/statesUI/StateUI.gd"



const COUNTRY_COUNT_X: int = 3
const BT_SEPARATION_X: int = 250

const LevelBtType = preload("res://src/user_interface/LevelBt.gd")
const LevelBtFactory = preload("res://src/user_interface/LevelBtFactory.gd")

onready var inGameClassicUI = loadStateUI("StateInGameClassic1QbitUI")

var vBoxContainer: VBoxContainer 
var initialUI: StateUI



func _ready():
	#yield(get_tree(), "idle_frame") #espera a que se terminen de agregar los botones y se recalcule el tamaño del ScrollContainer
	$ScrollContainer.scroll_vertical = GameDataExpert.obtainLevelListScroll()
	$TitleBanner.setTitle("Niveles")


func init(prevUI: StateUI)->void:
	initialUI = prevUI
	
	vBoxContainer = $ScrollContainer/VBoxContainer
	
	var levelCount: int = GameDataExpert.obtainLevelCount()
	
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
		
		
		auxHBoxContainer.call_deferred("add_child",auxLevelBt)


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
	inGameClassicUI.init(self,levelID)
	get_parent().call_deferred("add_child",inGameClassicUI)
	get_parent().call_deferred("remove_child",self)

func backButtonPressed()->void:
	get_parent().call_deferred("add_child",initialUI)
	get_parent().call_deferred("remove_child",self)
