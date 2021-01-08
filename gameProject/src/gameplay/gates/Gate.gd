extends Control


onready var spriteTexture = $Sprite.texture

var matrix: Array

var complexi = Complex.new().init(0,1)
var complexNegativei = Complex.new().init(0,-1)
var complex0 = Complex.new().init(0,0)
var complex1 = Complex.new().init(1,0)
var complexNegative1 = Complex.new().init(-1,0)
var complex1oversqrt2 = Complex.new().init(1/sqrt(2),0)
var complexNegative1oversqrt2 = Complex.new().init(-1/sqrt(2),0)



func _ready():
	var auxComp = Complex.new()
	auxComp.init(1,0)
	
	pass

func get_drag_data(pos):
	# Use another colorpicker as drag preview
	var control = Control.new()
	var gateSprite = Sprite.new()
	gateSprite.texture = spriteTexture
	control.add_child(gateSprite)
	gateSprite.position = Vector2(gateSprite.get_rect().position.x + 85,  gateSprite.get_rect().position.y + 130)
	#print(gateSprite.get_rect().position)
	set_drag_preview(control)
	
	return self

func is2QbitGate()->bool:
	return getMatrix().size() == 4


func getMatrix()->Array:
	return matrix

func getTexture()->Texture:
	return spriteTexture

func setSpriteToGateHolder(gateHolder)->void:
	gateHolder.setSpriteTexture(spriteTexture)
