const PLAYER_MASS = 10
const PLAYER_SPEED = 3

const AI_CHAOTIC_MASS = PLAYER_MASS * 0.2
const AI_CHAOTIC_SPEED = PLAYER_SPEED * 0.5

const AI_SPEED = 2

const AI_MASS = 10
const AI_BALAN_MASS = 20
const PLAYER_SPRITE_NAME = "priest"
const AI_SPRITE_NAME = "ghost"

const GHOST_SPRITE_NAME = "ghost"
const SKELETON_SPRITE_NAME = "skeleton"
const DEMON_SPRITE_NAME = "demon"
const ZOMBIE_SPRITE_NAME = "zombie"
const HELLHOUND_SPRITE_NAME = "hellhound"

var application

# PUBLIC
func _init(application):

	self.application = application

func create_player():
	return create_character(preload("res://src/ai.gd").PlayerAI.new(application), PLAYER_SPEED, PLAYER_MASS, true, PLAYER_SPRITE_NAME)
	
func create_swinging_opponent():
	return create_character(preload("res://src/ai.gd").SwingingAI.new(application), AI_SPEED, AI_MASS, false, HELLHOUND_SPRITE_NAME)

func create_following_opponent():
	return create_character(preload("res://src/ai.gd").FollowingAI.new(application), AI_SPEED, AI_MASS, false, ZOMBIE_SPRITE_NAME)

func create_balancing_opponent():
	return create_character(preload("res://src/ai.gd").BalancingAI.new(application), AI_SPEED, AI_BALAN_MASS, false, HELLHOUND_SPRITE_NAME)
	
func create_opposing_opponent():
	return create_character(preload("res://src/ai.gd").OpposingAI.new(application), AI_SPEED, AI_MASS, false, AI_SPRITE_NAME)

func create_sticking_opponent():
	return create_character(preload("res://src/ai.gd").StickingAI.new(application), AI_SPEED, 1, false, AI_SPRITE_NAME)
	
func create_evil_opponent():
	return create_character(preload("res://src/ai.gd").EvilAI.new(application), AI_SPEED, AI_MASS, false, DEMON_SPRITE_NAME)

func create_chaotic_opponent():
	return create_character(preload("res://src/ai.gd").ChaoticAI.new(application), AI_CHAOTIC_SPEED, AI_CHAOTIC_MASS, false, GHOST_SPRITE_NAME)

# PRIVATE 
func create_character(ai, velocity, mass, is_player, sprite_name):
	var character_scene = preload("res://scenes/character.xml")
	var character = character_scene.instance()
	character.init(application, ai, velocity, mass, is_player, sprite_name)
	return character
