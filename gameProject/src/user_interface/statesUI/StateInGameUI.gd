extends "res://src/user_interface/statesUI/StateUI.gd"

var prevUI



func backButtonPressed()->void:
	get_parent().call_deferred("add_child",prevUI)
	get_parent().call_deferred("remove_child",self)
