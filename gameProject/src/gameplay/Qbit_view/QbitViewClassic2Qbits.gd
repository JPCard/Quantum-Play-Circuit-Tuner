extends "res://src/gameplay/Qbit_view/QbitView.gd"


onready var currentSphereView2Qbits = $Spheres/CurrentSphereView2Qbits
onready var goalSphereView2Qbits = $Spheres/GoalSphereView2Qbits

onready var currentMatrixView2Qbits = $Matrices/CurrentMatrixView2Qbits
onready var goalMatrixView2Qbits = $Matrices/GoalMatrixView2Qbits


func _ready():
	goalSphereView2Qbits.moveToFirstGoalSphereLocation()
	goalSphereView2Qbits.moveToSecondGoalSphereLocation()
	currentSphereView2Qbits.moveToSecondCurrentSphereLocation()
	
	#rotateFirstCurrentQbitStateArrow(0,0,0)
	#rotateSecondCurrentQbitStateArrow(PI/2,0,0)
	#rotateFirstGoalQbitStateArrow(PI,0,0)
	#rotateSecondGoalQbitStateArrow(-PI/2,0,0)



func rotateFirstCurrentQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	currentSphereView2Qbits.rotateFirstQbitStateArrow(rotX, rotY, rotZ)

func rotateSecondCurrentQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	currentSphereView2Qbits.rotateSecondQbitStateArrow(rotX, rotY, rotZ)


func rotateFirstGoalQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	goalSphereView2Qbits.rotateFirstQbitStateArrow(rotX, rotY, rotZ)

func rotateSecondGoalQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	goalSphereView2Qbits.rotateSecondQbitStateArrow(rotX, rotY, rotZ)



func updateCurrentQbitSystem(matrix:Array)->void:
	currentMatrixView2Qbits.updateQbitSystem(matrix)

func updateGoalQbitSystem(matrix:Array)->void:
	goalMatrixView2Qbits.updateQbitSystem(matrix)

func rotateSpheresHorizontally(rotY: float)->void:
	currentSphereView2Qbits.rotateSpheresHorizontally(rotY)
	goalSphereView2Qbits.rotateSpheresHorizontally(rotY)

func renderSpheres()->void:
	currentSphereView2Qbits.renderSpheres()
	goalSphereView2Qbits.renderSpheres()
