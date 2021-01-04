extends Control

signal qbit_state_changed
signal level_won

const GATE_HOLDER_COUNT: int = 20
const GateHolderInstancer = preload("res://src/gameplay/circuit/GateHolder.tscn")

onready var hBoxContainer: HBoxContainer = $ScrollContainer/HBoxContainer

var initialQbitState : Array = [[Complex.new().init(0,0), Complex.new().init(1,0)]]
var goalQbitState : Array
var currentQbitState : Array = [[Complex.new().init(0,0), Complex.new().init(1,0)]]
var gates: Array = []
var mutexGates: Mutex



func _ready():
	mutexGates = Mutex.new()
	
	
	gates.resize(GATE_HOLDER_COUNT)
	
	createBlankColumn()
	
	var auxGateHolder
	for i in range(GATE_HOLDER_COUNT):
		auxGateHolder = GateHolderInstancer.instance()
		hBoxContainer.call_deferred("add_child", auxGateHolder)
		auxGateHolder.connect("no_gate", self, "removeGate", [i])
		auxGateHolder.connect("new_gate_dropped", self, "addGate", [i])
		
		gates[i] = null # no hay gate asignada a ese numero de compuerta
	
	createBlankColumn()


func setInitialQbitState(auxQbitState: Array)->void:
	initialQbitState = auxQbitState

func setGoalQbitState(auxQbitState: Array)->void:
	goalQbitState = auxQbitState


func addGate(gate, index)->void:
	mutexGates.lock()
	
	gates[index] = gate
	calculateQbitState()
	
	#print("agrega gate con mat: ", gate.getMatrix())
	
	mutexGates.unlock()


func removeGate(index)->void:
	mutexGates.lock()
	
	gates[index] = null
	calculateQbitState()
	
	#print("saca gate")
	
	mutexGates.unlock()



func calculateQbitState()->void:
	#print(currentQbitState)
	
	var auxQbitSate : Array = initialQbitState
	
	for i in range(GATE_HOLDER_COUNT):
		if(gates[i] != null):
			auxQbitSate = ComplexMatrixAlgebra.multiplyComplexMatrices(auxQbitSate, gates[i].getMatrix())
	
	currentQbitState = auxQbitSate
	
	#print(currentQbitState)
	
	emit_signal("qbit_state_changed", currentQbitState)
	
	if(currentQbitState[0][0].equals(goalQbitState[0][0]) && currentQbitState[0][1].equals(goalQbitState[0][1])):
		emit_signal("level_won")
	


func createBlankColumn()->void:
	var blankSpace:ColorRect = ColorRect.new()
	#blankSpace.rect_min_size = Vector2(198,50)
	blankSpace.modulate = 0
	hBoxContainer.call_deferred("add_child", blankSpace)
	blankSpace.mouse_filter = Control.MOUSE_FILTER_IGNORE


