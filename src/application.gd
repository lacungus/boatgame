extends Node

const SAVE_FILE_NAME = 'gamestate.txt'

var level_manager

var scene_manager

var character_factory

var direction

func _ready():
	scene_manager = preload("res://src/scene_manager.gd").new(self)
	level_manager = preload("res://src/level_manager.gd").new(self)
	character_factory = preload("res://src/character_factory.gd").new(self)
	
	direction = preload("res://src/direction.gd").new()
	
	load_game_state()
	
	set_process_input(true)
	
func get_scene_manager():
	return scene_manager

func get_level_manager():
	return level_manager

func get_character_factory():
	return character_factory

func get_boat():
	return get_node("/root/Game/boat")

func get_width():
	return self.get_parent().get_rect().size.width

func get_height():
	return self.get_parent().get_rect().size.height

func is_left_active():
	return Input.is_action_pressed("ui_left") || get_node("/root/Game/ui_layer/button_left").is_pressed()
	
func is_right_active():
	return Input.is_action_pressed("ui_right") || get_node("/root/Game/ui_layer/button_right").is_pressed()

func set_x(node, x):
	var node_pos = node.get_pos()
	node_pos.x = x
	node.set_pos(node_pos)

func on_level_won():
	var current_level = level_manager.get_current_level()
	level_manager.set_stars_per_level(current_level.get_index(), current_level.get_stars())
	scene_manager.goto_you_won()
	save_game_state(level_manager.get_current_index() + 1)
	
func on_level_lost():
	scene_manager.goto_you_lost()

func _input(event):
	if event.is_action("save") && !event.is_echo() && event.is_pressed():
		save_game_state()
	if event.is_action("reset") && !event.is_echo() && event.is_pressed():
		reset_game_state()
	

func load_game_state():
	var file = File.new()
	if !file.file_exists(SAVE_FILE_NAME):
		print("Save file not found")
		return
	
	file.open(SAVE_FILE_NAME, File.READ)
	
	var level_number = file.get_64()
	level_manager.set_count(level_number)
	var level_count = file.get_64()
	
	for i in range(level_count):
		var stars = file.get_64()
		if stars == -1:
			stars = null
		level_manager.set_stars_per_level(i + 1, stars)
	
	file.close()
	
	print("Game was loaded")

func save_game_state(current_level_index = null):
	var file = File.new()
	file.open(SAVE_FILE_NAME, File.WRITE)
	
	if current_level_index == null:
		current_level_index = level_manager.get_current_index()
		
	file.store_64(current_level_index)
	file.store_64(level_manager.get_level_count())
	
	for i in range(level_manager.get_level_count()):
		var stars = level_manager.get_stars_per_level(i + 1)
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
	Directory.new().remove(SAVE_FILE_NAME)
	print("Save file deleted")
	