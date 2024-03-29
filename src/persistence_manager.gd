extends Node

const SAVE_FILE_NAME = 'user://gamestate.txt'

var application

func _init(application):
	self.application = application

func load_game_state():
	var file = File.new()
	if !file.file_exists(SAVE_FILE_NAME):
		print("Save file not found")
		return
	
	file.open(SAVE_FILE_NAME, File.READ)
	
	var level_number = file.get_64()
	application.get_level_manager().set_current_level_id(level_number)
	var level_count = file.get_64()
	
	for i in range(level_count):
		var stars = file.get_64()
		if stars == -1:
			stars = null
		application.get_level_manager().set_stars(i + 1, stars)
	
	file.close()
	
	print("Game was loaded")

func save_game_state(current_level_index = null):
	var file = File.new()
	file.open(SAVE_FILE_NAME, File.WRITE)
	
	if current_level_index == null:
		current_level_index = application.get_level_manager().get_current_level_id()
		
	file.store_64(current_level_index)
	file.store_64(application.get_level_manager().get_level_count())
	
	for i in range(application.get_level_manager().get_level_count()):
		var stars = application.get_level_manager().get_stars(i + 1)
		if stars == null:
			stars = -1
		file.store_64(stars)
	
	file.close()
	print("Game was saved")

func write_level_to_file(file, index):
	pass
	
func read_index_to_file():
	pass

func reset_game_state():
	delete_game_state()
	load_game_state()
	
func delete_game_state():
	var directory = Directory.new()
	directory.open('user://')
	directory.remove(SAVE_FILE_NAME)
