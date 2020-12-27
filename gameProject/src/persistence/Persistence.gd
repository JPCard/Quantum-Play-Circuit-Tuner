extends Node

const GameData = preload("res://src/persistence/GameData.gd")
const SAVE_FILE_PATH = "user://save.dat"

var gameData: GameData # para acceso en memoria principal
var game_data_dict: Dictionary  # para guardar datos

var mutexGameData: Mutex
var mutexSaveGameFile: Mutex



func _init():
	mutexGameData = Mutex.new()
	mutexSaveGameFile = Mutex.new()
	
	initLoad()


func initLoad()->void:
	var aux_game_data_dict = load_game_from_file()
	gameData = GameData.new()
	
	if(aux_game_data_dict != null):
		game_data_dict = aux_game_data_dict
		gameData.deserialize(game_data_dict) # cargar datos
	else:
		game_data_dict = gameData.serialize()
	
	
	save_in_file() # guarda la game_data_dict actualizada


func saveCompleted(completed: bool)->void:
	mutexGameData.lock()
	gameData.setCompleted(completed)
	game_data_dict = gameData.serialize()
	mutexGameData.unlock()
	
	save_in_file()

func loadCompleted()->bool:
	return gameData.isCompleted()

func saveMaxCompletedLevelID(levelID: int)->void:
	mutexGameData.lock()
	gameData.setMaxCompletedLevelID(levelID)
	game_data_dict = gameData.serialize()
	mutexGameData.unlock()
	
	save_in_file()

func loadMaxCompletedLevelID()->int:
	return gameData.getMaxCompletedLevelID()

func saveLevelListScroll(scroll:int)->void:
	mutexGameData.lock()
	gameData.setLevelListScroll(scroll)
	game_data_dict = gameData.serialize()
	mutexGameData.unlock()
	
	save_in_file()

func loadLevelListScroll()->int:
	return gameData.levelListScroll

func saveCurrentLevelID(levelID:int)->void:
	mutexGameData.lock()
	gameData.setCurrentLevelID(levelID)
	game_data_dict = gameData.serialize()
	mutexGameData.unlock()
	
	save_in_file()

func loadCurrentLevelID()->int:
	return gameData.getCurrentLevelID()



func save_in_file():
	var save_game:File = File.new()
	
	mutexSaveGameFile.lock()
	
	save_game.open(SAVE_FILE_PATH, File.WRITE)
	save_game.store_string(JSON.print(game_data_dict," ")) # el espacio sirve para que haga new line
	save_game.close()
	
	mutexSaveGameFile.unlock()





func load_game_from_file():
	var save_game: File = File.new()
	if not save_game.file_exists(SAVE_FILE_PATH):
		return null #no se cargo porque no existe el archivo de partida guardada
	
	mutexSaveGameFile.lock()
	
	save_game.open(SAVE_FILE_PATH, File.READ)
	var aux_game_data_dict = parse_json(save_game.get_as_text())
	save_game.close()
	
	mutexSaveGameFile.unlock()
	#print(game_data_dict)
	return aux_game_data_dict




