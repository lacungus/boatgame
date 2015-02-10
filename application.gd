extends Node

const PLAYER_SPEED = 3

const AI_SPEED = 5

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
