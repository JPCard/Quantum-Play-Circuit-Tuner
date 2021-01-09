extends Control

onready var spheres: Control = $Spheres
onready var matrices: Control = $Matrices

var pressed = false
var last_position = Vector2()
var complex0: Complex = Complex.new().init(0,0)


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



# parameters -> matriz con 1 elemento -> el array de estado de un sistema de 1 qbit
# returns -> array con 2 elementos [teta, phi] que corresponden a [-rotY, rotZ] 
func stateToBlochSphereRotation(matrix: Array)->Array:
	
	var alpha: Complex = matrix[0][0]
	var beta: Complex = matrix[0][1]
	
	var teta: float = 2 * acos(alpha.absoluteValue())
	var phi: float
	
	if(alpha.equals(complex0) || beta.equals(complex0)):
		phi = 0 # es irrelevante el valor de phi en este caso porque esta apuntando hacia arriba o hacia abajo
	else:
		phi = beta.argument() - alpha.argument()
	
	return [teta, phi]



