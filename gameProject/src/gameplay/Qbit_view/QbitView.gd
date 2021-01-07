extends Control

onready var spheres: Control = $Spheres
onready var matrices: Control = $Matrices

var pressed = false
var last_position = Vector2()



func _ready():
	showSphereView()



func showMatrixView()->void:
	spheres.hide()
	matrices.show()


func showSphereView()->void:
	matrices.hide()
	spheres.show()


func rotateSpheresHorizontally(rotY: float)->void:
	pass

func renderSpheres()->void:
	pass

# En base al input de mouse genera una rotacion horizontal sobre la esfera de bloch
func _on_Spheres_gui_input(event):
	if event is InputEventMouseButton:
		pressed = event.is_pressed()
		if pressed:
			last_position = event.position
	elif event is InputEventMouseMotion and pressed:
		var delta = event.position - last_position
		last_position = event.position
		
		rotateSpheresHorizontally(delta.x * 0.01)
		renderSpheres()
