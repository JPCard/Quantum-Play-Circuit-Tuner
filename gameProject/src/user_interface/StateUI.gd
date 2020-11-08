extends Control
class_name StateUI


func _ready():
	pass 


func backButtonPressed()->void:
	pass


func _notification(notif):
	if notif == MainLoop.NOTIFICATION_WM_QUIT_REQUEST || notif == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		backButtonPressed()


func loadStateUI(stateName:String)-> StateUI:
	return load(GameGlobals.UI_STATES_FOLDER_PATH_BASE + stateName + ".tscn").instance()
