extends "res://src/gameplay/Qbit_view/sphere_view/SphereView.gd"

onready var blochSphere2D : BlochSphere2D = $BlochSphere2D 

func _ready():
	pass
	#renderSpheres()

func rotateSpheresHorizontally(rotY: float)->void:
	blochSphere2D.rotateBlochSphereHorizontally(rotY)


func renderSpheres()->void:
	blochSphere2D.renderSphere()

func moveToFirstGoalSphereLocation()->void:
	blochSphere2D.moveToFirstGoalSphereLocation()

# cambia el vector de estado del Qbit
# corrige ejes Y y Z, ya que en godot estan invertidos
func rotateStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	blochSphere2D.rotateStateArrow(rotX, rotZ, rotY)
