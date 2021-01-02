extends Node2D
class_name BlochSphere2D

const SPHERE_SEPARATION = 500
const BlochSphere = preload("res://src/gameplay/Qbit_view/sphere_view/BlochSphere.gd")

onready var blochSphereSprite: Sprite = $BlochSphereSprite
onready var viewport: Viewport = $Viewport
onready var blochSphere: BlochSphere = $Viewport/BlochSphere

var pressed = false
var last_position = Vector2()



# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.hide()
	renderSphere()

# genera una rotacion horizontal de la esfera de bloch entera
func rotateBlochSphereHorizontally(rotY: float)->void:
	blochSphere.rotateBlochSphereHorizontally(rotY)

func rotateStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	blochSphere.rotateStateArrow(rotX, rotY, rotZ)

func renderSphere()->void:
	var texture = viewport.get_texture()
	blochSphereSprite.texture = texture

# cambia de posicion a la segunda esfera de bloch actual
func moveToSecondCurrentSphereLocation()->void:
	blochSphere.translation = Vector3(SPHERE_SEPARATION, 0, 0)

# cambia de posicion a la esfera objetivo de arriba
func moveToFirstGoalSphereLocation()->void:
	blochSphere.translation = Vector3(SPHERE_SEPARATION * 2, 0, 0)
	
# cambia de posicion a la esfera objetivo de abajo
func moveToSecondGoalSphereLocation()->void:
	blochSphere.translation = Vector3(SPHERE_SEPARATION * 3, 0, 0)
