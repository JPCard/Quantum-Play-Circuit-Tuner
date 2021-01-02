extends Spatial


onready var stateArrow: Spatial = $BlochSphereContainer/StateArrow
onready var blochSphereContainer: Spatial = $BlochSphereContainer


func _ready():
	pass
	#rotateStateArrow(0,0,PI/2)
	#rotateBlochSphereHorizontally(PI/2)

# rota la flecha que marca el estado del Qbit para apuntar hacia otro estado
func rotateStateArrow(rotX: float, rotY: float, rotZ: float)->void:
	stateArrow.rotate_x(rotX)
	stateArrow.rotate_y(rotY)
	stateArrow.rotate_z(rotZ)


# genera una rotacion horizontal de la esfera de bloch entera
func rotateBlochSphereHorizontally(rotY: float)->void:
	blochSphereContainer.rotate_y(rotY)
