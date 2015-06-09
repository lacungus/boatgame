const PLAYER_MASS = 100
const PLAYER_SPEED = 2

const AI_SPEED = 2
const AI_MASS = 10
const AI_BALAN_MASS = 20

# Chaotic = Ghost
const AI_CHAOTIC_MASS = PLAYER_MASS * 0.2
const AI_CHAOTIC_SPEED = PLAYER_SPEED * 0.3
const AI_CHAOTIC_SPRITE_NAME = "ghost"

# Following = Zombie
const AI_FOLLOWING_MASS = PLAYER_MASS * 1
const AI_FOLLOWING_SPEED = PLAYER_SPEED * 0.3
const AI_FOLLOWING_SPRITE_NAME = "zombie"

# Sticking = Skeleton
const AI_STICKING_MASS = PLAYER_MASS * 0.2
const AI_STICKING_SPEED = PLAYER_SPEED * 0.5
const AI_STICKING_SPRITE_NAME = "skeleton"

# Evil = Hellhound
const AI_EVIL_MASS = PLAYER_MASS * 0.2
const AI_EVIL_SPEED = PLAYER_SPEED * 0.5
const AI_EVIL_SPRITE_NAME = "hellhound"

# Balancing = Demon
const AI_BALANCING_MASS = PLAYER_MASS
const AI_BALANCING_SPEED = PLAYER_SPEED
const AI_BALANCING_SPRITE_NAME = "demon"

const PLAYER_SPRITE_NAME = "priest"
const AI_SPRITE_NAME = "ghost"

var application

# PUBLIC
func _init(application):

	self.application = application

func create(type):
	if type == "player":
		return create_player()
	elif type == "following":
		return create_following_opponent()
	elif type == "chaotic":
		return create_chaotic_opponent()
	elif type == "balancing":
		return create_balancing_opponent()
	elif type == "swinging":
		return create_swinging_opponent()
	elif type == "evil":
		return create_evil_opponent()
	elif type == "sticking":
		return create_sticking_opponent()
	else:
		print("Unknown type: " + str(type))
		OS.get_main_loop().quit()

func create_player():
	return create_character(preload("res://src/ai.gd").PlayerAI.new(application), PLAYER_SPEED, PLAYER_MASS, true, PLAYER_SPRITE_NAME)
	
func create_sticking_opponent():
	return create_character(preload("res://src/ai.gd").StickingAI.new(application), AI_STICKING_SPEED, AI_STICKING_MASS, false, AI_STICKING_SPRITE_NAME)

func create_following_opponent():
	return create_character(preload("res://src/ai.gd").FollowingAI.new(application), AI_FOLLOWING_SPEED, AI_FOLLOWING_MASS, false, AI_FOLLOWING_SPRITE_NAME)

func create_balancing_opponent():
	return create_character(preload("res://src/ai.gd").BalancingAI.new(application), AI_BALANCING_SPEED, AI_BALANCING_MASS, false, AI_BALANCING_SPRITE_NAME)
	
func create_opposing_opponent():
	return create_character(preload("res://src/ai.gd").OpposingAI.new(application), AI_SPEED, AI_MASS, false, AI_SPRITE_NAME)

func create_evil_opponent():
	return create_character(preload("res://src/ai.gd").EvilAI.new(application), AI_EVIL_SPEED, AI_EVIL_MASS, false, AI_EVIL_SPRITE_NAME)

func create_chaotic_opponent():
	return create_character(preload("res://src/ai.gd").ChaoticAI.new(application), AI_CHAOTIC_SPEED, AI_CHAOTIC_MASS, false, AI_CHAOTIC_SPRITE_NAME)

# PRIVATE 
func create_character(ai, velocity, mass, is_player, sprite_name):
	var character_scene = preload("res://scenes/character.xml")
	var character = character_scene.instance()
	character.init(application, ai, velocity, mass, is_player, sprite_name)
	return character
