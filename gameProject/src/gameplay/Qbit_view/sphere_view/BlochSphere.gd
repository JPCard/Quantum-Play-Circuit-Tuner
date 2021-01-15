extends Spatial


onready var stateArrow: Spatial = $BlochSphereContainer/StateArrow
onready var blochSphereContainer: Spatial = $BlochSphereContainer


func _ready():
	pass
	#rotateStateArrow(0,0,PI/2)
	#rotateBlochSphereHorizontally(PI/2)

# rota la flecha que marca el estado del Qbit para apuntar hacia otro estado
func rotateStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	
	$BlochSphereContainer/StateArrow.rotation = Vector3(rotX, rotY, rotZ)
	
	# no sirven porque rotan cada vez desde donde estaba rotado anteriormente
	#$BlochSphereContainer/StateArrow.rotate_x(rotX) 
	#$BlochSphereContainer/StateArrow.rotate_y(rotY)
	#$BlochSphereContainer/StateArrow.rotate_z(rotZ)


# genera una rotacion horizontal de la esfera de bloch entera
func rotateBlochSphereHorizontally(rotY: float)->void:
	blochSphereContainer.rotate_y(rotY)

func showStateArrow()->void:
	stateArrow.show()

func hideStateArrow()->void:
	stateArrow.hide()



