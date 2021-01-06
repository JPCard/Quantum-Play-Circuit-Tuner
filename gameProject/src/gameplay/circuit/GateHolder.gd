extends Control

signal new_gate_dropped
signal no_gate

const GATE_HOLDER_TEXTURE = preload("res://assets/art/InGameUI/circuit/gateHolder.png")

onready var sprite = $Sprite

var gate = null setget setGate, getGate
var atTheTop: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	setSpriteTexture(GATE_HOLDER_TEXTURE)

# solo para circuitos con 2 gateHolders
func init(auxAtTheTop):
	atTheTop = auxAtTheTop


func setSpriteTexture(auxTexture: Texture)->void:
	$Sprite.texture = auxTexture # se llama antes del ready

func setGate(auxGate)->void:
	gate = auxGate

func getGate():
	return gate


func gateDrop(auxGate)->void:
	if(getGate() != auxGate):
		setGate(auxGate)
		emit_signal("new_gate_dropped", gate) # dispara metodos para cambiar el estado de las vistas de los qbits
		$DragZone.mouse_filter = Control.MOUSE_FILTER_STOP
		
		setSpriteTexture(gate.getTexture())
		
		if(atTheTop):
			$Sprite.show()
		else:
			$Sprite.hide() # el sprite lo va a mostrar el gateHolder de arriba




func createDragData(pos):
	# Use another colorpicker as drag preview
	
	if(getGate() != null):
		var control = Control.new()
		var gateSprite = Sprite.new()
		gateSprite.texture = sprite.texture
		control.add_child(gateSprite)
		gateSprite.position = Vector2(gateSprite.get_rect().position.x + 85,  gateSprite.get_rect().position.y + 130)
		#print(gateSprite.get_rect().position)
		set_drag_preview(control)
		
		var auxGate = getGate()
		
		reset()
		
		
		
		return auxGate


func reset()->void:
	
	if(getGate() != null):
		setGate(null) # pierde su gate porque se va a arrastrar
		setSpriteTexture(GATE_HOLDER_TEXTURE)
		$Sprite.show()
		$DragZone.mouse_filter = Control.MOUSE_FILTER_PASS
		
		emit_signal("no_gate")





