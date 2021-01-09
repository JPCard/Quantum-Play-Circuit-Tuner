extends Control

const BlochSphere = preload("res://src/gameplay/Qbit_view/sphere_view/BlochSphere.gd")

onready var blochSphereSprite: Sprite = $BlochSphereSprite
onready var viewport: Viewport = $Viewport
onready var blochSphere: BlochSphere = $Viewport/BlochSphere





# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func rotateSpheresHorizontally(rotY: float)->void:
	pass


func renderSpheres()->void:
	pass


func rotateStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	pass
