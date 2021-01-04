extends Control

signal new_gate_dropped
signal no_gate

const GATE_HOLDER_TEXTURE = preload("res://assets/art/InGameUI/circuit/gateHolder.png")

onready var sprite = $Sprite

var gate = null

# Called when the node enters the scene tree for the first time.
func _ready():
	setSpriteTexture(GATE_HOLDER_TEXTURE)


func setSpriteTexture(auxTexture: Texture)->void:
	$Sprite.texture = auxTexture # se llama antes del ready


func gateDrop(auxGate)->void:
	if(gate != auxGate):
		gate = auxGate
		emit_signal("new_gate_dropped", gate) # dispara metodos para cambiar el estado de las vistas de los qbits
		setSpriteTexture(gate.getTexture())
		mouse_filter = Control.MOUSE_FILTER_STOP


func get_drag_data(pos):
	# Use another colorpicker as drag preview
	
	if(gate != null):
		var control = Control.new()
		var gateSprite = Sprite.new()
		gateSprite.texture = sprite.texture
		control.add_child(gateSprite)
		gateSprite.position = Vector2(gateSprite.get_rect().position.x + 85,  gateSprite.get_rect().position.y + 130)
		#print(gateSprite.get_rect().position)
		set_drag_preview(control)
		
		var auxGate = gate
		
		gate = null  # pierde su gate porque se va a arrastrar
		setSpriteTexture(GATE_HOLDER_TEXTURE)
		mouse_filter = Control.MOUSE_FILTER_PASS
		
		emit_signal("no_gate")
		
		return auxGate
