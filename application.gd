extends Node

const PLAYER_SPEED = 3

const AI_SPEED = 1

# TODO enum?
const DIRECTION_LEFT = "left"
const DIRECTION_RIGHT = "right"

func get_player():
	return get_node("/root/Game/player")
	
func get_opponent():
	return get_node("/root/Game/ai_1")
	
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
