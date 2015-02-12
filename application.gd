extends Node

const PLAYER_SPEED = 3

const AI_SPEED = 1

# TODO enum?
const DIRECTION_LEFT = "left"
const DIRECTION_RIGHT = "right"

var level_manager

var current_level

func set_level_manager(level_manager):
	self.level_manager = level_manager

func get_level_manager():
	return level_manager

func set_current_level(current_level):
	self.current_level = current_level
	
func get_player():
	for character in current_level.get_characters():
		if character.get_is_player():
			return character
	return null
	
func get_boat():
	return get_node("/root/Game/boat")

func get_width():
	return self.get_parent().get_rect().size.width

func get_height():
	return self.get_parent().get_rect().size.height

# TODO consider moving all direction logic into a separate class
func opposite_direction(direction):
	if direction == DIRECTION_LEFT:
		return DIRECTION_RIGHT
	if direction == DIRECTION_RIGHT:
		return DIRECTION_LEFT
	print("Unable to get opposite direction: " + direction)
	return null

func create_character(ai, velocity, mass, is_player):
	var character_scene = preload("res://character.xml")
	var character = character_scene.instance()
	
	character.set_ai(ai)
	character.set_velocity(velocity)
	character.set_is_player(is_player)
	# TODO set mass
	return character

func create_player():
	return create_character(preload("res://ai.gd").PlayerAI.new(), PLAYER_SPEED, 0, true)
	
func create_swinging_opponent():
	return create_character(preload("res://ai.gd").SwingingAI.new(self), AI_SPEED, 0, false)

func create_following_opponent():
	return create_character(preload("res://ai.gd").FollowingAI.new(self), AI_SPEED, 0, false)

func set_x(node, x):
	var node_pos = node.get_pos()
	node_pos.x = x
	node.set_pos(node_pos)
