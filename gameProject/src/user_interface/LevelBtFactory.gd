extends Node


# LevelBtFactory
const LevelBtInstancer = preload("res://src/user_interface/LevelBt.tscn")

const LVL_BT_UNLOCKED_NORMAL_TEXTURE = preload("res://assets/art/LevelSelectUI/unlockedLevelBt.png")
const LVL_BT_UNLOCKED_PRESSED_TEXTURE = preload("res://assets/art/LevelSelectUI/unlockedLevelBt_Pressed.png")
const LVL_BT_COMPLETED_NORMAL_TEXTURE = preload("res://assets/art/LevelSelectUI/completedLevelBt.png")
const LVL_BT_COMPLETED_PRESSED_TEXTURE = preload("res://assets/art/LevelSelectUI/completedLevelBt_Pressed.png")
const LVL_BT_LOCKED_NORMAL_TEXTURE = preload("res://assets/art/LevelSelectUI/lockedLevelBt.png")


enum LEVEL_BT_TYPES {
	UNLOCKED,
	COMPLETED,
	LOCKED
}


func _init():
	pass # Replace with function body.


# Pre: levelBtTypes debe ser un elemento del enum LEVEL_BT_TYPES
static func _createLevelBt(levelBtTypes, levelID:int)->LevelBt:
	var levelBt = LevelBtInstancer.instance()
	
	levelBt.init(levelID)
	
	match (levelBtTypes):
		LEVEL_BT_TYPES.UNLOCKED:
			setUnlockedTextures(levelBt)
			levelBt.setUnlocked(true)
			levelBt.setCompleted(false)
			
		LEVEL_BT_TYPES.COMPLETED: 
			setCompletedTextures(levelBt)
			levelBt.setUnlocked(true)
			levelBt.setCompleted(true)
			
		LEVEL_BT_TYPES.LOCKED: 
			levelBt.texture_normal = LVL_BT_LOCKED_NORMAL_TEXTURE
			#levelBt.disabled = true
			levelBt.setUnlocked(false)
			levelBt.setCompleted(false)
	
	return levelBt


static func setUnlockedTextures(levelBt):
	levelBt.texture_normal = LVL_BT_UNLOCKED_NORMAL_TEXTURE
	levelBt.texture_pressed = LVL_BT_UNLOCKED_PRESSED_TEXTURE

static func setCompletedTextures(levelBt):
	levelBt.texture_normal = LVL_BT_COMPLETED_NORMAL_TEXTURE
	levelBt.texture_pressed = LVL_BT_COMPLETED_PRESSED_TEXTURE


static func createUnlockedLevelBt(levelID:int):
	return _createLevelBt(LEVEL_BT_TYPES.UNLOCKED, levelID)

static func createCompletedLevelBt(levelID:int):
	return _createLevelBt(LEVEL_BT_TYPES.COMPLETED, levelID)

static func createLockedLevelBt(levelID:int):
	return _createLevelBt(LEVEL_BT_TYPES.LOCKED, levelID)



