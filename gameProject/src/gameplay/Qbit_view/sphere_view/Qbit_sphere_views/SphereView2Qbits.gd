extends "res://src/gameplay/Qbit_view/sphere_view/Qbit_sphere_views/SphereView1Qbit.gd"


onready var blochSphere2D_2 : BlochSphere2D = $BlochSphere2D_2 

func _ready():
	.renderSpheres()
	


func rotateSpheresHorizontally(rotY: float)->void:
	.rotateSpheresHorizontally(rotY)
	blochSphere2D_2.rotateBlochSphereHorizontally(rotY)


func renderSpheres()->void:
	.renderSpheres()
	blochSphere2D_2.renderSphere()



func moveToFirstGoalSphereLocation()->void:
	blochSphere2D.moveToFirstGoalSphereLocation()


# cambia de posicion a la esfera objetivo de abajo
func moveToSecondGoalSphereLocation()->void:
	blochSphere2D_2.moveToSecondGoalSphereLocation()


func moveToSecondCurrentSphereLocation()->void:
	blochSphere2D_2.moveToSecondCurrentSphereLocation()

# cambia el vector de estado del Qbit de arriba
func rotateFirstQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	blochSphere2D.rotateStateArrow(rotX, rotY, rotZ)

# cambia el vector de estado del Qbit de abajo
func rotateSecondQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	blochSphere2D_2.rotateStateArrow(rotX, rotY, rotZ)

