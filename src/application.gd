extends Node

var level_manager

var scene_manager

var character_factory

var persistence_manager

var direction

var musicPlayer

var songPlaying

func _ready():
	scene_manager = preload("res://src/scene_manager.gd").new(self)
	level_manager = preload("res://src/level_manager.gd").new(self)
	character_factory = preload("res://src/character_factory.gd").new(self)
	persistence_manager = preload("res://src/persistence_manager.gd").new(self)
	
	direction = preload("res://src/direction.gd").new()
	
	persistence_manager.load_game_state()
	
	set_process_input(true)
	

	playMusic("res://assets/music/Zanzibar.ogg")
	
func playMusic(song, loop = true):
	if (musicPlayer == null):
		musicPlayer = StreamPlayer.new()
		add_child(musicPlayer)
	
	if (song != songPlaying):
		var stream = load(song)
		musicPlayer.set_stream(stream)
		musicPlayer.play()
		musicPlayer.set_loop(loop)
		songPlaying = song

	
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
	persistence_manager.save_game_state(level_manager.get_current_level_id() + 1)
	
	
func on_level_lost():
	scene_manager.goto_you_lost()

func _input(event):
	if event.is_action("save") && !event.is_echo() && event.is_pressed():
		persistence_manager.save_game_state()
	if event.is_action("reset") && !event.is_echo() && event.is_pressed():
		persistence_manager.reset_game_state()
