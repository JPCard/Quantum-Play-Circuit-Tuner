extends "res://src/gameplay/Qbit_view/QbitView.gd"


onready var currentSphereView1Qbit = $Spheres/CurrentSphereView1Qbit
onready var goalSphereView1Qbit = $Spheres/GoalSphereView1Qbit

onready var currentMatrixView1Qbit = $Matrices/CurrentMatrixView1Qbit
onready var goalMatrixView1Qbit = $Matrices/GoalMatrixView1Qbit



func _ready():
	goalSphereView1Qbit.moveToFirstGoalSphereLocation()
	#rotateFirstCurrentQbitStateArrow(PI,0,0)



func rotateFirstCurrentQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	currentSphereView1Qbit.rotateStateArrow(rotX, rotY, rotZ)

func rotateFirstGoalQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	goalSphereView1Qbit.rotateStateArrow(rotX, rotY, rotZ)


func updateCurrentQbitSystem(qbitStateMatrix:Array)->void:
	$Matrices/CurrentMatrixView1Qbit.updateQbitSystem(qbitStateMatrix)
	#rotateFirstCurrentQbitStateArrow(rotX,rotY,rotZ)

func updateGoalQbitSystem(qbitStateMatrix:Array)->void:
	$Matrices/GoalMatrixView1Qbit.updateQbitSystem(qbitStateMatrix)
	#rotateFirstGoalQbitStateArrow(rotX,rotY,rotZ)


func rotateSpheresHorizontally(rotY: float)->void:
	currentSphereView1Qbit.rotateSpheresHorizontally(rotY)
	goalSphereView1Qbit.rotateSpheresHorizontally(rotY)

func renderSpheres()->void:
	currentSphereView1Qbit.renderSpheres()
	goalSphereView1Qbit.renderSpheres()
