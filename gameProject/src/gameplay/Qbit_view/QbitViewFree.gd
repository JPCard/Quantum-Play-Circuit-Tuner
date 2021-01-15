extends "res://src/gameplay/Qbit_view/QbitView.gd"


onready var sphereView2Qbits = $Spheres/SphereView2Qbits

onready var matrixView2Qbits = $Matrices/MatrixView2Qbits

func _ready():
	sphereView2Qbits.moveToSecondCurrentSphereLocation()
	
	#rotateFirstCurrentQbitStateArrow(0,0,0)
	#rotateSecondCurrentQbitStateArrow(PI/2,0,0)



func rotateFirstCurrentQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	$Spheres/SphereView2Qbits.rotateFirstQbitStateArrow(rotX, rotY, rotZ)

func rotateSecondCurrentQbitStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	$Spheres/SphereView2Qbits.rotateSecondQbitStateArrow(rotX, rotY, rotZ)


func updateCurrentQbitSystem(qbitStateMatrix1: Array, qbitStateMatrix2: Array)->void:
	$Matrices/MatrixView2Qbits.updateQbitSystem(TwoQbitStateFrom1QbitStates(qbitStateMatrix1, qbitStateMatrix2))
	
	var blochAngles: Array = stateToBlochSphereRotation(qbitStateMatrix1)
	rotateFirstCurrentQbitStateArrow(0,-blochAngles[0],blochAngles[1])
	
	blochAngles = stateToBlochSphereRotation(qbitStateMatrix2)
	rotateSecondCurrentQbitStateArrow(0,-blochAngles[0],blochAngles[1])


func updateCurrentTwoQbitSystem(twoQbitStateMatrix: Array)->void:
	$Matrices/MatrixView2Qbits.updateQbitSystem(twoQbitStateMatrix)
	
	if(abs(twoQbitStateMatrix[0][0].probability() - 1) <= GameGlobals.NUMERIC_TOLERANCE): # estado 00
		rotateFirstCurrentQbitStateArrow(0, 0, 0)
		rotateSecondCurrentQbitStateArrow(0, 0, 0)
		# mostrar vista esfera
	elif(abs(twoQbitStateMatrix[0][3].probability() - 1) <= GameGlobals.NUMERIC_TOLERANCE): # estado 11
		rotateFirstCurrentQbitStateArrow(0, PI, 0)
		rotateSecondCurrentQbitStateArrow(0, PI, 0)
		# mostrar vista esfera
	else:
		pass # esconder vista esfera




func rotateSpheresHorizontally(rotY: float)->void:
	sphereView2Qbits.rotateSpheresHorizontally(rotY)

func renderSpheres()->void:
	sphereView2Qbits.renderSpheres()
