extends Control

signal matrix_view_selected
signal sphere_view_selected

onready var matrixSelectBt = $MatrixSelectBt
onready var matrixSelectedSprite = $MatrixSelectBt/MatrixSelectedSprite
onready var sphereSelectBt = $SphereSelectBt
onready var sphereSelectedSprite = $SphereSelectBt/SphereSelectedSprite

var sphereViewSelected = true setget setSphereViewSelected, isSphereViewSelected


# Called when the node enters the scene tree for the first time.
func _ready():
	showSphereSelectedSprite()

func showMatrixSelectedSprite()->void:
	matrixSelectedSprite.show()
	sphereSelectedSprite.hide()

func showSphereSelectedSprite()->void:
	matrixSelectedSprite.hide()
	sphereSelectedSprite.show()

func selectMatrixView()->void:
	if(isSphereViewSelected()):
		setSphereViewSelected(false)
		showMatrixSelectedSprite()
		emit_signal("matrix_view_selected")
	


func selectSphereView()->void:
	if(!isSphereViewSelected()):
		setSphereViewSelected(true)
		showSphereSelectedSprite()
		emit_signal("sphere_view_selected")
	

func isSphereViewSelected()->bool:
	return sphereViewSelected

func setSphereViewSelected(cond: bool)->void:
	sphereViewSelected = cond
