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
	$Spheres/CurrentSphereView2Qbits.rotateFirstQbitStateArrow(rotX, rotY, rotZ)

func rotateSecondCurrentQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	$Spheres/CurrentSphereView2Qbits.rotateSecondQbitStateArrow(rotX, rotY, rotZ)


func rotateFirstGoalQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	$Spheres/GoalSphereView2Qbits.rotateFirstQbitStateArrow(rotX, rotY, rotZ)

func rotateSecondGoalQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	$Spheres/GoalSphereView2Qbits.rotateSecondQbitStateArrow(rotX, rotY, rotZ)



func updateCurrentQbitSystem(qbitStateMatrix1:Array, qbitStateMatrix2:Array)->void:
	$Matrices/CurrentMatrixView2Qbits.updateQbitSystem(TwoQbitStateFrom1QbitStates(qbitStateMatrix1, qbitStateMatrix2))
	
	var blochAngles: Array = stateToBlochSphereRotation(qbitStateMatrix1)
	rotateFirstCurrentQbitStateArrow(0,-blochAngles[0],blochAngles[1])
	
	blochAngles = stateToBlochSphereRotation(qbitStateMatrix2)
	rotateSecondCurrentQbitStateArrow(0,-blochAngles[0],blochAngles[1])
	
	# mostrar vista esfera


func updateCurrentTwoQbitSystem(twoQbitStateMatrix: Array)->void:
	$Matrices/CurrentMatrixView2Qbits.updateQbitSystem(twoQbitStateMatrix)
	
	if(abs(twoQbitStateMatrix[0][0].probability() - 1) <= GameGlobals.NUMERIC_TOLERANCE): # estado 00
		rotateFirstCurrentQbitStateArrow(0, 0, 0)
		rotateSecondCurrentQbitStateArrow(0, 0, 0)
		currentSphereView2Qbits.showQbitStates()
	elif(abs(twoQbitStateMatrix[0][1].probability() - 1) <= GameGlobals.NUMERIC_TOLERANCE): # estado 01
		rotateFirstCurrentQbitStateArrow(0, 0, 0)
		rotateSecondCurrentQbitStateArrow(0, PI, 0)
		currentSphereView2Qbits.showQbitStates()
	elif(abs(twoQbitStateMatrix[0][2].probability() - 1) <= GameGlobals.NUMERIC_TOLERANCE): # estado 10
		rotateFirstCurrentQbitStateArrow(0, PI, 0)
		rotateSecondCurrentQbitStateArrow(0, 0, 0)
		currentSphereView2Qbits.showQbitStates()
	elif(abs(twoQbitStateMatrix[0][3].probability() - 1) <= GameGlobals.NUMERIC_TOLERANCE): # estado 11
		rotateFirstCurrentQbitStateArrow(0, PI, 0)
		rotateSecondCurrentQbitStateArrow(0, PI, 0)
		currentSphereView2Qbits.showQbitStates()
	else:
		currentSphereView2Qbits.hideQbitStates()


func updateGoalQbitSystem(qbitStateMatrix1:Array, qbitStateMatrix2:Array)->void:
	$Matrices/GoalMatrixView2Qbits.updateQbitSystem(TwoQbitStateFrom1QbitStates(qbitStateMatrix1, qbitStateMatrix2)) 
	
	var blochAngles: Array = stateToBlochSphereRotation(qbitStateMatrix1)
	rotateFirstGoalQbitStateArrow(0,-blochAngles[0],blochAngles[1])
	
	blochAngles = stateToBlochSphereRotation(qbitStateMatrix2)
	rotateSecondGoalQbitStateArrow(0,-blochAngles[0],blochAngles[1])
	




func rotateSpheresHorizontally(rotY: float)->void:
	currentSphereView2Qbits.rotateSpheresHorizontally(rotY)
	goalSphereView2Qbits.rotateSpheresHorizontally(rotY)

func renderSpheres()->void:
	currentSphereView2Qbits.renderSpheres()
	goalSphereView2Qbits.renderSpheres()






