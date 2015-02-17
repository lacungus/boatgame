const PLAYER_SPEED = 3

const AI_SPEED = 2

const PLAYER_MASS = 10

const AI_MASS = 10

const PLAYER_SPRITE_NAME = "captain"

const AI_SPRITE_NAME = "enemy_01"

var application

# PUBLIC
func _init(application):
	self.application = application

func create_player():
	return create_character(preload("res://src/ai.gd").PlayerAI.new(application), PLAYER_SPEED, PLAYER_MASS, true, PLAYER_SPRITE_NAME)
	
func create_swinging_opponent():
	return create_character(preload("res://src/ai.gd").SwingingAI.new(application), AI_SPEED, AI_MASS, false, AI_SPRITE_NAME)

func create_following_opponent():
	return create_character(preload("res://src/ai.gd").FollowingAI.new(application), AI_SPEED, AI_MASS, false, AI_SPRITE_NAME)

# PRIVATE 
func create_character(ai, velocity, mass, is_player, sprite_name):
	var character_scene = preload("res://scenes/character.xml")
	var character = character_scene.instance()
	character.init(application, ai, velocity, mass, is_player, sprite_name)
	return character
