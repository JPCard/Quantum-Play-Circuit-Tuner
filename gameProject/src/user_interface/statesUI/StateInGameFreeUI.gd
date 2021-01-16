extends "res://src/user_interface/statesUI/StateInGameUI.gd"

func _ready():
	$Circuit2Qbits.setClassicMode(false)
	$TitleBannerInGame.setTitle("Modo libre")
	#print_debug("entra al modo libre")

func init(auxPrevUI: StateUI)->void:
	prevUI = auxPrevUI
	
	var initialStateMatrix1 = [[Complex.new().init(1,0), Complex.new().init(0,0)]]
	var initialStateMatrix2 = [[Complex.new().init(1,0), Complex.new().init(0,0)]]
	updateCurrentQbitViews(initialStateMatrix1, initialStateMatrix2)
	$Circuit2Qbits.setInitialQbitStates(initialStateMatrix1, initialStateMatrix2)
	


func updateCurrentQbitViews(qbitStateMatrix1: Array, qbitStateMatrix2: Array)->void:
	$QbitViewFree.updateCurrentQbitSystem(qbitStateMatrix1, qbitStateMatrix2)

# cada vez que se entra a este menu
func _on_Circuit2Qbits_tree_entered():
	$Circuit2Qbits.resetGateHolders()


func updateCurrentQbitViews2QbitState(twoQbitStateMatrix: Array):
	$QbitViewFree.updateCurrentTwoQbitSystem(twoQbitStateMatrix)
