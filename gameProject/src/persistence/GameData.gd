extends Node

const COMPLETED_INI_VALUE: bool = false
const MAX_COMPLETED_LEVEL_ID_INI_VALUE: int = -1 # tiene que ser -1 para que el MAX_COMPLETED_LEVEL_ID_INI_VALUE + 1 sea 0 -> 1er nivel
const LEVEL_LIST_SCROLL_INI_VALUE: int = 0
const CURRENT_LEVEL_ID_INI_VALUE: int = 0

const COMPLETED_KEY: String = "completed"
const MAX_COMPLETED_LEVEL_ID_KEY: String = "max_completed_level_id"
const LEVEL_LIST_SCROLL_KEY: String = "level_list_scroll"
const CURRENT_LEVEL_ID_KEY: String = "current_level_id"

var completed: bool setget setCompleted, isCompleted
var maxCompletedLevelID: int setget setMaxCompletedLevelID, getMaxCompletedLevelID
var levelListScroll: int setget setLevelListScroll, getLevelListScroll
var currentLevelID: int setget setCurrentLevelID, getCurrentLevelID
var initialStateMatrices: Array = []
var goalStateMatrices: Array = []


var complexi = Complex.new().init(0,1)
var complexNegativei = Complex.new().init(0,-1)
var complex0 = Complex.new().init(0,0)
var complex1 = Complex.new().init(1,0)
var complexNegative1 = Complex.new().init(-1,0)
var complex1oversqrt2 = Complex.new().init(1/sqrt(2),0)
var complexNegative1oversqrt2 = Complex.new().init(-1/sqrt(2),0)




func _init():
	completed = COMPLETED_INI_VALUE
	maxCompletedLevelID = MAX_COMPLETED_LEVEL_ID_INI_VALUE
	levelListScroll = LEVEL_LIST_SCROLL_INI_VALUE
	currentLevelID = CURRENT_LEVEL_ID_INI_VALUE
	
	addLevel([[complex0, complex1]],[[complex1, complex0]])

func addLevel(initialStateMatrix: Array, goalStateMatrix: Array)->void:
	initialStateMatrices.append(initialStateMatrix)
	goalStateMatrices.append(goalStateMatrix)


func setCompleted(auxCompleted: bool)->void:
	completed = auxCompleted

func isCompleted()->bool:
	return completed

func setMaxCompletedLevelID(levelID: int)->void:
	maxCompletedLevelID = levelID

func getMaxCompletedLevelID()->int:
	return maxCompletedLevelID

func setLevelListScroll(scroll: int)->void:
	levelListScroll = scroll

func getLevelListScroll()->int:
	return levelListScroll

func setCurrentLevelID(levelID: int)->void:
	currentLevelID = levelID

func getCurrentLevelID()->int:
	return currentLevelID

# Pre: 0 <= levelID < initialStateMatrices.size()
func obtainInitialStateMatrix(levelID: int)->Array:
	return initialStateMatrices[levelID]

# Pre: 0 <= levelID < initialStateMatrices.size()
func obtainGoalStateMatrix(levelID: int)->Array:
	return goalStateMatrices[levelID]

func getLevelCount()->int:
	return initialStateMatrices.size()


func serialize()->Dictionary:
	return {
	COMPLETED_KEY : isCompleted(),
	MAX_COMPLETED_LEVEL_ID_KEY : getMaxCompletedLevelID(),
	LEVEL_LIST_SCROLL_KEY : getLevelListScroll(),
	CURRENT_LEVEL_ID_KEY : getCurrentLevelID()
	}
	
	# los LevelData no se guardan porque siempre se tienen que leer del codigo


func deserialize(dict: Dictionary)->void:
	
	setCompleted(dict[COMPLETED_KEY])
	setMaxCompletedLevelID(dict[MAX_COMPLETED_LEVEL_ID_KEY])
	setLevelListScroll(dict[LEVEL_LIST_SCROLL_KEY])
	setCurrentLevelID(dict[CURRENT_LEVEL_ID_KEY])
	# los LevelData no se guardan porque siempre se tienen que leer del codigo



