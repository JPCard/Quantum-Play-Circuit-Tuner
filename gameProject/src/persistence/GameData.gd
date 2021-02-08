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
	
	#Nivel 1: |0> -----|X|------|1>
	addLevel1Qbit(complex1, complex0, complex0, complex1)
	#Nivel 2: |0> --------------|0>
	#         |0> -----|X|------|1>
	addLevel2QbitsInitialStatesGoalStates(complex1, complex0, complex1, complex0, complex1, complex0, complex0, complex1)
	#Nivel 3: |0> -----|H|------|+>
	addLevel1Qbit(complex1, complex0, complex1oversqrt2, complex1oversqrt2)
	#Nivel 4: |0> --|X|---|H|---|->
	addLevel1Qbit(complex1, complex0, complex1oversqrt2, complexNegative1oversqrt2)
	#Nivel 5: |0> -----|H|------|+>
	#         |0> -----|H|------|+>
	addLevel2QbitsInitialStatesGoalStates(complex1, complex0, complex1, complex0, complex1oversqrt2, complex1oversqrt2, complex1oversqrt2, complex1oversqrt2)
	#Nivel 6: |0> -----|H|--|---
	#         |0> ----------X---
	addLevel2QbitsInitialStatesGoalState(complex1, complex0, complex1, complex0, complex1oversqrt2, complex0, complex0, complex1oversqrt2)
	
# Pre: - la suma de las probabilidades de initialComplex0 y initialComplex1 debe ser 1
#      - la suma de las probabilidades de goalComplex0 y goalComplex1 debe ser 1
func addLevel1Qbit(initialComplex0: Complex, initialComplex1: Complex, goalComplex0: Complex, goalComplex1: Complex)->void:
	
	initialStateMatrices.append([[initialComplex0, initialComplex1]])
	goalStateMatrices.append([[goalComplex0, goalComplex1]])


# Pre: - la suma de las probabilidades de initialComplex0Qbit1, initialComplex1Qbit1 debe ser 1
#	   - la suma de las probabilidades de initialComplex0Qbit2, initialComplex1Qbit2 debe ser 1
#	   - la suma de las probabilidades de goalComplex0Qbit1, goalComplex1Qbit1 debe ser 1
#	   - la suma de las probabilidades de goalComplex0Qbit2, goalComplex1Qbit2 debe ser 1
# sistemas de 2 qbits con iniciales 1x2 y objetivos 1x2
func addLevel2QbitsInitialStatesGoalStates(initialComplex0Qbit1: Complex, initialComplex1Qbit1: Complex, initialComplex0Qbit2: Complex, initialComplex1Qbit2: Complex, 
					goalComplex0Qbit1: Complex, goalComplex1Qbit1: Complex, goalComplex0Qbit2: Complex, goalComplex1Qbit2: Complex)->void:
	
	initialStateMatrices.append([ [[initialComplex0Qbit1, initialComplex1Qbit1]], [[initialComplex0Qbit2, initialComplex1Qbit2]] ])
	goalStateMatrices.append([ [[goalComplex0Qbit1, goalComplex1Qbit1]], [[goalComplex0Qbit2, goalComplex1Qbit2]] ]) 


# Pre: - la suma de las probabilidades de initialComplex0Qbit1, initialComplex1Qbit1 debe ser 1
#	   - la suma de las probabilidades de initialComplex0Qbit2, initialComplex1Qbit2 debe ser 1
#	   - la suma de las probabilidades de goalComplex00, goalComplex01, goalComplex10, goalComplex11 debe ser 1
# todo sistemas de 2 qbits con iniciales 1x2 y objetivos 1x4
func addLevel2QbitsInitialStatesGoalState(initialComplex0Qbit1: Complex, initialComplex1Qbit1: Complex, initialComplex0Qbit2: Complex, initialComplex1Qbit2: Complex, 
					goalComplex00: Complex, goalComplex01: Complex, goalComplex10: Complex, goalComplex11: Complex)->void:
	
	initialStateMatrices.append([ [[initialComplex0Qbit1, initialComplex1Qbit1]], [[initialComplex0Qbit2, initialComplex1Qbit2]] ])
	goalStateMatrices.append([ [[goalComplex00, goalComplex01, goalComplex10, goalComplex11]] ]) 



# Pre: - la suma de las probabilidades de initialComplex00, initialComplex01, initialComplex10, initialComplex11 debe ser 1
#	   - la suma de las probabilidades de goalComplex0Qbit1, goalComplex1Qbit1 debe ser 1
#	   - la suma de las probabilidades de goalComplex0Qbit2, goalComplex1Qbit2 debe ser 1
# sistemas de 2 qbits con inicial 1x4 y objetivos 1x2
func addLevel2QbitsInitialStateGoalStates(initialComplex00: Complex, initialComplex01: Complex, initialComplex10: Complex, initialComplex11: Complex, 
					goalComplex0Qbit1: Complex, goalComplex1Qbit1: Complex, goalComplex0Qbit2: Complex, goalComplex1Qbit2: Complex)->void:
	
	initialStateMatrices.append([ [[initialComplex00, initialComplex01, initialComplex10, initialComplex11]] ])
	goalStateMatrices.append([ [[goalComplex0Qbit1, goalComplex1Qbit1]], [[goalComplex0Qbit2, goalComplex1Qbit2]] ]) 


# Pre: - la suma de las probabilidades de initialComplex00, initialComplex01, initialComplex10, initialComplex11 debe ser 1
#	   - la suma de las probabilidades de goalComplex00, goalComplex01, goalComplex10, goalComplex11 debe ser 1
# sistemas de 2 qbits con inicial 1x4 y objetivo 1x4
func addLevel2QbitsInitialStateGoalState(initialComplex00: Complex, initialComplex01: Complex, initialComplex10: Complex, initialComplex11: Complex, 
					goalComplex00: Complex, goalComplex01: Complex, goalComplex10: Complex, goalComplex11: Complex)->void:
	
	initialStateMatrices.append([ [[initialComplex00, initialComplex01, initialComplex10, initialComplex11]] ])
	goalStateMatrices.append([ [[goalComplex00, goalComplex01, goalComplex10, goalComplex11]] ]) 








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



