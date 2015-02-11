var count = 0

var application

func _init(application):
	self.application = application
	
func get_next_level():
	count = count + 1
	if count == 1:
		var characters = [application.create_player(), application.create_swinging_opponent()]
		var positions = [Vector2(100, 100), Vector2(200, 200)]
		return preload("level.gd").new(characters, positions)

	if count == 2:
		var characters = [application.create_player(), application.create_swinging_opponent(), application.create_swinging_opponent()]
		var positions = [Vector2(100, 100), Vector2(300, 300), Vector2(400, 300)]
		return preload("level.gd").new(characters, positions)
	
	return null;