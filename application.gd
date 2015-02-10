extends Node

func get_player():
	return get_node("/root/Game/player")
	
func get_opponent():
	return get_node("/root/Game/opponent")
	
func get_boat():
	return get_node("/root/Game/boat")

func get_width():
	return self.get_parent().get_rect().size.width

func get_height():
	return self.get_parent().get_rect().size.height
