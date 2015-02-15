const PLAYER_SPEED = 3

const AI_SPEED = 1

const PLAYER_MASS = 1

const AI_MASS = 1

var application

# PUBLIC
func _init(application):
	self.application = application

func create_player():
	return create_character(preload("res://src/ai.gd").PlayerAI.new(application), PLAYER_SPEED, PLAYER_MASS, true)
	
func create_swinging_opponent():
	return create_character(preload("res://src/ai.gd").SwingingAI.new(application), AI_SPEED, AI_MASS, false)

func create_following_opponent():
	return create_character(preload("res://src/ai.gd").FollowingAI.new(application), AI_SPEED, AI_MASS, false)

# PRIVATE 
func create_character(ai, velocity, mass, is_player):
	var character_scene = preload("res://scenes/character.xml")
	var character = character_scene.instance()
	
	character.set_ai(ai)
	character.set_velocity(velocity)
	character.set_is_player(is_player)
	character.set_mass(mass)
	return character
