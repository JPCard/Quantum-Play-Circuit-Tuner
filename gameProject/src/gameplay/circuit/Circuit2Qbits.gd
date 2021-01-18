extends Control

signal qbit_state_changed(currentQbitState1, currentQbitState1)
signal two_qbit_state_changed(current2QbitState)
signal level_won


const GATE_HOLDER_COUNT: int = 20
const GATE_HOLDER_SEPARATION_Y: int = 75
const GateHolderInstancer = preload("res://src/gameplay/circuit/GateHolder.tscn")

onready var hBoxContainer: HBoxContainer = $ScrollContainer/HBoxContainer

var initialQbitState1 : Array = [[Complex.new().init(0,0), Complex.new().init(1,0)]]
var initialQbitState2 : Array = [[Complex.new().init(0,0), Complex.new().init(1,0)]]
var goalQbitState1 : Array
var goalQbitState2 : Array
var goal2QbitState : Array 
var current2QbitState : Array
var gatesQbit1: Array = []
var gatesQbit2: Array = []
var mutexGates: Mutex

var complex0: Complex = Complex.new().init(0, 0)
var complex1: Complex = Complex.new().init(1, 0)
var pauliXMatrix : Array = [[complex0, complex1],[complex1, complex0]]

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
	
	auxGateHolder1.connect("prev_2_qbits_no_gate", auxGateHolder2, "resetVisuals")
	auxGateHolder1.connect("new_gate_2_qbits_dropped", auxGateHolder2, "gateDropVisuals")
	auxGateHolder1.connect("new_gate_1_qbit_dropped", auxGateHolder2, "resetVisuals")
	
	
	auxGateHolder2.connect("prev_2_qbits_no_gate", auxGateHolder1, "resetVisuals")
	auxGateHolder2.connect("new_gate_2_qbits_dropped", auxGateHolder1, "gateDropVisuals")
	auxGateHolder2.connect("new_gate_1_qbit_dropped", auxGateHolder1, "resetVisuals")


func createVBoxContainer()->VBoxContainer:
	var vBoxContainer: VBoxContainer = VBoxContainer.new()
	vBoxContainer.set("custom_constants/separation", GATE_HOLDER_SEPARATION_Y)
	hBoxContainer.call_deferred("add_child", vBoxContainer)
	vBoxContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	return vBoxContainer


func setInitialQbitStates(auxQbitState1: Array, auxQbitState2: Array)->void:
	initialQbitState1 = auxQbitState1
	initialQbitState2 = auxQbitState2
	

func setGoalQbitStates(auxQbitState1: Array, auxQbitState2: Array)->void:
	goalQbitState1 = auxQbitState1
	goalQbitState2 = auxQbitState2
	goal2QbitState = QbitView.TwoQbitStateFrom1QbitStates(goalQbitState1, goalQbitState2)


func addGateQbit1(gate, index)->void:
	mutexGates.lock()
	
	
	gatesQbit1[index] = gate
	if(gate.is2QbitGate()):
		gatesQbit2[index] = gate
	elif(gatesQbit2[index] != null && gatesQbit2[index].is2QbitGate()):
		# como llega una de 1 qbit -> hay que sacar la de 2 qbit del slot vecino si es que hubiese
		gatesQbit2[index] = null
	
	calculateQbitState()
	
	#print("agrega gate 1 con mat: ", gate.getMatrix())
	
	
	
	mutexGates.unlock()


func removeGateQbit1(index)->void:
	mutexGates.lock()
	
	if(gatesQbit1[index].is2QbitGate()):
		gatesQbit1[index] = null
		gatesQbit2[index] = null
	else:
		gatesQbit1[index] = null
	
	calculateQbitState()
	
	#print("saca gate 1")
	
	mutexGates.unlock()


func addGateQbit2(gate, index)->void:
	mutexGates.lock()
	
	gatesQbit2[index] = gate
	if(gate.is2QbitGate()):
		gatesQbit1[index] = gate
	elif(gatesQbit1[index] != null && gatesQbit1[index].is2QbitGate()):
		# como llega una de 1 qbit -> hay que sacar la de 2 qbit del slot vecino si es que hubiese
		gatesQbit1[index] = null
	
	calculateQbitState()
	
	#print("agrega gate 2 con mat: ", gate.getMatrix())
	
	
	
	mutexGates.unlock()


func removeGateQbit2(index)->void:
	mutexGates.lock()
	
	if(gatesQbit2[index].is2QbitGate()):
		gatesQbit2[index] = null
		gatesQbit1[index] = null
	else:
		gatesQbit2[index] = null
	
	calculateQbitState()
	
	#print("saca gate 2")
	
	mutexGates.unlock()


func calculateQbitState()->void:
	#print(currentQbitState)
	
	var auxCurrentQbitSate1 : Array = initialQbitState1
	var auxCurrentQbitSate2 : Array = initialQbitState2
	var oneQbitState : bool = true
	var auxCurrent2QbitsState : Array
	var aux2QbitGateMatrix : Array
	
	
	# TODO revisar esto para gates de 1 y 2 qbits
	# tener en cuenta que las compuertas para 2 qbits se agregan en gatesQbit1 y gatesQbit2
	for i in range(GATE_HOLDER_COUNT):
		if(gatesQbit1[i] == null || !gatesQbit1[i].is2QbitGate()):
			if(oneQbitState): # 1 qbit states (2 de 1x2)
				if(gatesQbit1[i] != null):
					auxCurrentQbitSate1 = ComplexMatrixAlgebra.multiplyComplexMatrices(auxCurrentQbitSate1, gatesQbit1[i].getMatrix())
				if(gatesQbit2[i] != null):
					auxCurrentQbitSate2 = ComplexMatrixAlgebra.multiplyComplexMatrices(auxCurrentQbitSate2, gatesQbit2[i].getMatrix())
			else: # 2 qbit state (1x4)
				
				if(gatesQbit1[i] != null):
					if(gatesQbit2[i] != null): # gate1 (x) gate2
						aux2QbitGateMatrix = ComplexMatrixAlgebra.tensorMultiplyComplexMatrices(gatesQbit1[i].getMatrix(), gatesQbit2[i].getMatrix())
					else: # gate1 (x) I
						aux2QbitGateMatrix = ComplexMatrixAlgebra.tensorPostMultiplyDim2IdentityToComplexMatrix(gatesQbit1[i].getMatrix())
					
					auxCurrent2QbitsState = ComplexMatrixAlgebra.multiplyComplexMatrices(auxCurrent2QbitsState, aux2QbitGateMatrix)
				elif(gatesQbit2[i] != null): # I (x) gate2
					aux2QbitGateMatrix = ComplexMatrixAlgebra.tensorPreMultiplyDim2IdentityToComplexMatrix(gatesQbit2[i].getMatrix())
					
					auxCurrent2QbitsState = ComplexMatrixAlgebra.multiplyComplexMatrices(auxCurrent2QbitsState, aux2QbitGateMatrix)
				#else:
				# no habia gate arriba ni abajo
			
		else: # es una gate de 2 qbits
			
			if(oneQbitState):
				# analisis para el caso de la gate cX
				if(abs(auxCurrentQbitSate1[0][1].probability() - 1) < GameGlobals.NUMERIC_TOLERANCE): # control bit = 1
					auxCurrentQbitSate2 = ComplexMatrixAlgebra.multiplyComplexMatrices(auxCurrentQbitSate2, pauliXMatrix) # aplica not al 2do qbit
					# oneQbitSate sigue siendo true
				elif(abs(auxCurrentQbitSate1[0][0].probability() - 1) > GameGlobals.NUMERIC_TOLERANCE): # control bit != 0
					oneQbitState = false
					auxCurrent2QbitsState = QbitView.TwoQbitStateFrom1QbitStates(auxCurrentQbitSate1, auxCurrentQbitSate2)
					auxCurrent2QbitsState = ComplexMatrixAlgebra.multiplyComplexMatrices(auxCurrent2QbitsState, gatesQbit1[i].getMatrix())
				#else: control bit = 0
				#	pass
			else:
				auxCurrent2QbitsState = ComplexMatrixAlgebra.multiplyComplexMatrices(auxCurrent2QbitsState, gatesQbit1[i].getMatrix())
			
	
	
	
	if(oneQbitState):
		auxCurrent2QbitsState = QbitView.TwoQbitStateFrom1QbitStates(auxCurrentQbitSate1, auxCurrentQbitSate2)
		emit_signal("qbit_state_changed", auxCurrentQbitSate1, auxCurrentQbitSate2)
	else:
		emit_signal("two_qbit_state_changed", auxCurrent2QbitsState)
	
	
	
	if(isClassicMode()):
		var ok: bool = true
		var i: int = 0
		
		while (ok && i < auxCurrent2QbitsState[0].size()):
			ok = auxCurrent2QbitsState[0][i].equals(goal2QbitState[0][i])
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
			if(gateHolder.has_method("removeGate")): # solo se activa si es gateHolder
				gateHolder.removeGate()
	
	if(gatesQbit1.size() > 0): 
		# hay que resetear las gates del circuito
		for i in range(GATE_HOLDER_COUNT):
			gatesQbit1[i] = null # no hay gate asignada a ese numero de compuerta
			gatesQbit2[i] = null # no hay gate asignada a ese numero de compuerta
		
		calculateQbitState() # recalcula el estado una vez que saca todas las gates
	



