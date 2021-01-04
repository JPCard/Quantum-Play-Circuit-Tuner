extends "res://src/gameplay/Qbit_view/QbitView.gd"


onready var sphereView2Qbits = $Spheres/SphereView2Qbits

onready var matrixView2Qbits = $Matrices/MatrixView2Qbits

func _ready():
	sphereView2Qbits.moveToSecondCurrentSphereLocation()
	
	#rotateFirstCurrentQbitStateArrow(0,0,0)
	#rotateSecondCurrentQbitStateArrow(PI/2,0,0)



func rotateFirstCurrentQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	sphereView2Qbits.rotateFirstQbitStateArrow(rotX, rotY, rotZ)

func rotateSecondCurrentQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	sphereView2Qbits.rotateSecondQbitStateArrow(rotX, rotY, rotZ)


func updateCurrentQbitSystem(matrix:Array)->void:
	matrixView2Qbits.updateQbitSystem(matrix)


func rotateSpheresHorizontally(rotY: float)->void:
	sphereView2Qbits.rotateSpheresHorizontally(rotY)

func renderSpheres()->void:
	sphereView2Qbits.renderSpheres()