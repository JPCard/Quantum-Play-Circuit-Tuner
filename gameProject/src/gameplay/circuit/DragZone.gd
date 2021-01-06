extends Control



func get_drag_data(pos):
	return get_parent().createDragData(pos)
