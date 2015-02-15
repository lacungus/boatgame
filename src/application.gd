extends Node

const PLAYER_SPEED = 3

const AI_SPEED = 1

const PLAYER_MASS = 10

const AI_MASS = 1

# TODO enum?
const DIRECTION_LEFT = "left"
const DIRECTION_RIGHT = "right"

var level_manager

var scene_manager

func _ready():
	scene_manager = preload("res://src/scene_manager.gd").new(self)
	level_manager = preload("res://src/level_manager.gd").new(self)
	
func get_scene_manager():
	return scene_manager

func get_level_manager():
	return level_manager

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

func create_character(ai, velocity, mass, is_player):
	var character_scene = preload("res://scenes/character.xml")
	var character = character_scene.instance()
	
	character.set_ai(ai)
	character.set_velocity(velocity)
	character.set_is_player(is_player)
	character.set_mass(mass)
	return character

func create_player():
	return create_character(preload("res://src/ai.gd").PlayerAI.new(self), PLAYER_SPEED, PLAYER_MASS, true)
	
func create_swinging_opponent():
	return create_character(preload("res://src/ai.gd").SwingingAI.new(self), AI_SPEED, AI_MASS, false)

func create_following_opponent():
	return create_character(preload("res://src/ai.gd").FollowingAI.new(self), AI_SPEED, AI_MASS, false)

func set_x(node, x):
	var node_pos = node.get_pos()
	node_pos.x = x
	node.set_pos(node_pos)

func on_level_won():
	scene_manager.goto_you_won()
	
func on_level_lost():
	scene_manager.goto_you_lost()
