extends Control

signal gate_dropped

# definir las funciones can_drop_data(pos, data) y drop_data(pos, data) para permitir que dropeen sobre este control

# devuelve si me pueden dropear encima o no
func can_drop_data(pos, data):
	return true


# aca va la data que dropean encima
func drop_data(pos, data):
	#print("llega data")
	emit_signal("gate_dropped", data) # envia la gate que le llego
