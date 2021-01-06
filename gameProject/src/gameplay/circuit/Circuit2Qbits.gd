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

var classicMode: bool setget setClassicMode, isClassicMode

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

func setClassicMode(cond: bool)->void:
	classicMode = cond

func isClassicMode()->bool:
	return classicMode


func createGateHolderColumn(index)->void:
	var auxVBoxContainer = createVBoxContainer()
	
	# top gate holder
	var auxGateHolder1 = GateHolderInstancer.instance()
	auxVBoxContainer.call_deferred("add_child", auxGateHolder1)
	auxGateHolder1.connect("no_gate", self, "removeGateQbit1", [index])
	auxGateHolder1.connect("new_gate_dropped", self, "addGateQbit1", [index])
	auxGateHolder1.init(true)
	
	# bottom gate holder
	var auxGateHolder2 = GateHolderInstancer.instance()
	
	
	auxVBoxContainer.call_deferred("add_child", auxGateHolder2)
	auxGateHolder2.connect("no_gate", self, "removeGateQbit2", [index])
	auxGateHolder2.connect("new_gate_dropped", self, "addGateQbit2", [index])
	auxGateHolder2.init(false)
	
	auxGateHolder1.connect("no_gate", auxGateHolder2, "reset")
	auxGateHolder1.connect("new_gate_dropped", auxGateHolder2, "gateDrop")
	
	auxGateHolder2.connect("no_gate", auxGateHolder1, "reset")
	auxGateHolder2.connect("new_gate_dropped", auxGateHolder1, "gateDrop")


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
	
	
	if(gatesQbit2[index] == null || gatesQbit2[index].getMatrix().size() == 2): 
		# si el otro lugar esta vacio o tiene una compuerta de 1 qbit
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
	
	if(gatesQbit1[index] == null || gatesQbit1[index].getMatrix().size() == 2):
		# si el otro lugar esta vacio o tiene una compuerta de 1 qbit
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
	
	# TODO revisar esto para gates de 1 y 2 qbits
	for i in range(GATE_HOLDER_COUNT):
		if(gatesQbit1[i] != null):
			auxQbitSate = ComplexMatrixAlgebra.multiplyComplexMatrices(auxQbitSate, gatesQbit1[i].getMatrix())
	
	currentQbitState = auxQbitSate
	
	#print(currentQbitState)
	
	emit_signal("qbit_state_changed", currentQbitState)
	
	if(isClassicMode()):
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


func resetGateHolders()->void:
	for vBoxContainer in $ScrollContainer/HBoxContainer.get_children():
		for gateHolder in vBoxContainer.get_children(): # hay varios gateHolder por columna
			if(gateHolder.has_method("reset")): # solo se activa si es gateHolder
				gateHolder.reset()
