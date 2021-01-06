extends Control

signal qbit_state_changed
signal level_won


const GATE_HOLDER_COUNT: int = 20
const GATE_HOLDER_SEPARATION_Y: int = 75
const GateHolderInstancer = preload("res://src/gameplay/circuit/GateHolder.tscn")

onready var hBoxContainer: HBoxContainer = $ScrollContainer/HBoxContainer

var initialQbitState : Array = [[Complex.new().init(0,0), Complex.new().init(1,0)]]
var goalQbitState : Array
var currentQbitState : Array = [[Complex.new().init(0,0), Complex.new().init(1,0)]]
var gatesQbit1: Array = []
var gatesQbit2: Array = []
var mutexGates: Mutex



func _ready():
	mutexGates = Mutex.new()
	
	
	gatesQbit1.resize(GATE_HOLDER_COUNT)
	gatesQbit2.resize(GATE_HOLDER_COUNT)
	
	createBlankColumn()
	
	for i in range(GATE_HOLDER_COUNT):
		createGateHolderColumn(i)
		
		gatesQbit1[i] = null # no hay gate asignada a ese numero de compuerta
		gatesQbit2[i] = null # no hay gate asignada a ese numero de compuerta
	
	createBlankColumn()

func createGateHolderColumn(index)->void:
	var auxVBoxContainer = createVBoxContainer()
	
	# top gate holder
	var auxGateHolder = GateHolderInstancer.instance()
	auxVBoxContainer.call_deferred("add_child", auxGateHolder)
	auxGateHolder.connect("no_gate", self, "removeGateQbit1", [index])
	auxGateHolder.connect("new_gate_dropped", self, "addGateQbit1", [index])
	
	# bottom gate holder
	auxGateHolder = GateHolderInstancer.instance()
	auxVBoxContainer.call_deferred("add_child", auxGateHolder)
	auxGateHolder.connect("no_gate", self, "removeGateQbit2", [index])
	auxGateHolder.connect("new_gate_dropped", self, "addGateQbit2", [index])
	


func createVBoxContainer()->VBoxContainer:
	var vBoxContainer: VBoxContainer = VBoxContainer.new()
	vBoxContainer.set("custom_constants/separation", GATE_HOLDER_SEPARATION_Y)
	hBoxContainer.call_deferred("add_child", vBoxContainer)
	vBoxContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	return vBoxContainer


func setInitialQbitState(auxQbitState: Array)->void:
	initialQbitState = auxQbitState

func setGoalQbitState(auxQbitState: Array)->void:
	goalQbitState = auxQbitState


func addGateQbit1(gate, index)->void:
	mutexGates.lock()
	
	
	if(gate.getMatrix().size() == 1 || gatesQbit2[index] == null):
		gatesQbit1[index] = gate
		calculateQbitState()
	
	print("agrega gate 1 con mat: ", gate.getMatrix())
	
	mutexGates.unlock()


func removeGateQbit1(index)->void:
	mutexGates.lock()
	
	gatesQbit1[index] = null
	calculateQbitState()
	
	print("saca gate 1")
	
	mutexGates.unlock()

func addGateQbit2(gate, index)->void:
	mutexGates.lock()
	
	if(gate.getMatrix().size() == 1 || gatesQbit1[index] == null):
		gatesQbit2[index] = gate
		calculateQbitState()
	
	print("agrega gate 2 con mat: ", gate.getMatrix())
	
	mutexGates.unlock()


func removeGateQbit2(index)->void:
	mutexGates.lock()
	
	gatesQbit2[index] = null
	calculateQbitState()
	
	print("saca gate 2")
	
	mutexGates.unlock()


func calculateQbitState()->void:
	#print(currentQbitState)
	
	var auxQbitSate : Array = initialQbitState
	
	for i in range(GATE_HOLDER_COUNT):
		if(gatesQbit1[i] != null):
			auxQbitSate = ComplexMatrixAlgebra.multiplyComplexMatrices(auxQbitSate, gatesQbit1[i].getMatrix())
	
	currentQbitState = auxQbitSate
	
	#print(currentQbitState)
	
	emit_signal("qbit_state_changed", currentQbitState)
	
	var ok: bool = true
	var i: int = 0
	
	while (ok && i < currentQbitState[0].size()):
		ok = currentQbitState[0][i].equals(goalQbitState[0][i])
		i += 1
	
	if(ok):
		emit_signal("level_won")
	


func createBlankColumn()->void:
	var blankSpace:ColorRect = ColorRect.new()
	#blankSpace.rect_min_size = Vector2(198,50)
	blankSpace.modulate = 0
	hBoxContainer.call_deferred("add_child", blankSpace)
	blankSpace.mouse_filter = Control.MOUSE_FILTER_IGNORE


