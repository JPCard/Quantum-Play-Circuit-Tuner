extends TextureButton
class_name LevelBt

var levelIDLabel: Label
var levelID: int  setget setLevelID,getLevelID
var unlocked: bool setget setUnlocked, isUnlocked
var completed: bool setget setCompleted, isCompleted

# Called when the node enters the scene tree for the first time.
func _ready():
	rect_size = Vector2(350,350)


func init(auxLevelID:int)->void:
	levelIDLabel = $LevelIDLabel
	setLevelID(auxLevelID)

func setUnlocked(cond: bool)->void:
	unlocked = cond

func isUnlocked()->bool:
	return unlocked

func setCompleted(cond: bool)->void:
	completed = cond

func isCompleted()->bool:
	return completed


func setLevelID(auxLevelID:int)->void:
	levelID = auxLevelID
	levelIDLabel.text = str(levelID + 1)


func getLevelID()->int:
	return levelID

