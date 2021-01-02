extends "res://src/user_interface/statesUI/StateInGameUI.gd"


func init(auxPrevUI: StateUI, levelID: int)->void:
	prevUI = auxPrevUI
	$TitleBannerInGame.setTitle("Nivel  " + str(levelID + 1))


func win()->void:
	# mostrar un popup que te permita ir al siguiente nivel o volver al menu de seleccion de niveles
	pass
