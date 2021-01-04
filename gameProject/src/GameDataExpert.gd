extends Node



func obtainCompleted()->bool:
	return Persistence.loadCompleted()

func obtainMaxCompletedLevelID()->int:
	return Persistence.loadMaxCompletedLevelID()

func obtainLevelListScroll()->int:
	return Persistence.loadLevelListScroll()

func obtainCurrentLevelID()->int:
	return Persistence.loadCurrentLevelID()

func saveCompleted(completed: bool)->void:
	Persistence.saveCompleted(completed)

func saveMaxCompletedLevelID(levelID: int)->void:
	Persistence.saveMaxCompletedLevelID(levelID)

func saveLevelListScroll(scroll: int)->void:
	Persistence.saveLevelListScroll(scroll)

func saveCurrentLevelID(levelID: int)->void:
	Persistence.saveCurrentLevelID(levelID)

func obtainLevelCount()->int:
	return Persistence.loadLevelCount()

# Asume desbloqueo secuencial de niveles
func obtainMaxUnlockedLevelID()->int:
	return obtainMaxCompletedLevelID() + 1

# Asume desbloqueo secuencial de niveles
func obtainLevelCompletionState(levelID: int)->bool:
	return levelID <= obtainMaxCompletedLevelID()

func obtainInitialStateMatrix(levelID: int)->Array:
	return Persistence.loadInitialStateMatrix(levelID)

func obtainGoalStateMatrix(levelID: int)->Array:
	return Persistence.loadGoalStateMatrix(levelID)




