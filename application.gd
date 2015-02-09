extends Node

func get_player():
	return get_node("/root/Game/player")
	
func get_opponent():
	return get_node("/root/Game/opponent")
