extends TextureButton
class_name LevelBt


var levelID: int  setget setLevelID,getLevelID
var levelIDLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	rect_size = Vector2(350,350)


func init(auxLevelID:int)->void:
	levelIDLabel = $LevelIDLabel
	setLevelID(auxLevelID)


func setLevelID(auxLevelID:int)->void:
	levelID = auxLevelID
	levelIDLabel.text = str(levelID + 1)


func getLevelID()->int:
	return levelID

