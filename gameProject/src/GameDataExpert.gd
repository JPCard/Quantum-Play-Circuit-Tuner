extends Node





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _init():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func obtainLevelCount():
	return 10


func obtainMaxUnlockedLevelID():
	return 4


func obtainLevelCompletionState(levelID):
	return true


func obtainLevelListScroll():
	return 100



