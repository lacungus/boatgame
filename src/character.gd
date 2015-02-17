extends RigidBody2D

const VECTOR_LEFT = Vector2(-1, 0)
const VECTOR_RIGHT = Vector2(1, 0)

var velocity

var ai

var application

var is_player

var sprite_name 

var previous_direction = null

var animation_player

# PUBLIC 
func init(application, ai, velocity, mass, is_player, sprite_name):
	self.application = application
	self.ai = ai
	self.velocity = velocity
	self.mass = mass
	self.is_player = is_player
	self.sprite_name = sprite_name

func _ready():
	delete_wrong_sprites()
	
	animation_player = get_node(sprite_name).get_node("AnimationPlayer")
	animation_player.stop_all()
	
	ai.set_character(self)
	set_fixed_process(true)
	
func _fixed_process(delta):
	var decision = ai.make_decision()
	run(decision)
	
func is_dead():
	return get_pos().y > application.get_height()

func get_is_player():
	return is_player

# PRIVATE
func run(direction):
	if direction == null:
		if previous_direction != direction:
			if animation_player.has_animation("front"):
				animation_player.play("front")
			else:
				animation_player.stop_all()
	if direction == application.DIRECTION_LEFT:
		if previous_direction != direction:
			animation_player.play("going_left")
		apply_impulse(VECTOR_LEFT, Vector2(-self.velocity * self.mass, 0))
	if direction == application.DIRECTION_RIGHT:
		if previous_direction != direction:
			animation_player.play("going_right")
		apply_impulse(VECTOR_RIGHT, Vector2(self.velocity * self.mass, 0))

	previous_direction = direction
	
func delete_wrong_sprites():
	for child in get_children():
		if (child extends AnimatedSprite) && (child.get_name() != sprite_name):
			self.remove_and_delete_child(child)
