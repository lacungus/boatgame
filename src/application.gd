extends Node

# TODO enum?
const DIRECTION_LEFT = "left"
const DIRECTION_RIGHT = "right"

var level_manager

var scene_manager

var character_factory

func _ready():
	scene_manager = preload("res://src/scene_manager.gd").new(self)
	level_manager = preload("res://src/level_manager.gd").new(self)
	character_factory = preload("res://src/character_factory.gd").new(self)
	
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

# TODO consider moving all direction logic into a separate class
func opposite_direction(direction):
	if direction == DIRECTION_LEFT:
		return DIRECTION_RIGHT
	if direction == DIRECTION_RIGHT:
		return DIRECTION_LEFT
	print("Unable to get opposite direction: " + direction)
	return null

func set_x(node, x):
	var node_pos = node.get_pos()
	node_pos.x = x
	node.set_pos(node_pos)

func on_level_won():
	scene_manager.goto_you_won()
	
func on_level_lost():
	scene_manager.goto_you_lost()
