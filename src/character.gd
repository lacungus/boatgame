extends RigidBody2D

const VECTOR_LEFT = Vector2(-1, 0)
const VECTOR_RIGHT = Vector2(1, 0)

# TODO rename
# velocity
var velocity

var ai

var application

var is_player

var previous_direction = null

var animation_player

func run(direction):	
	if direction == null:
		if previous_direction != direction:
		#animation_player.stop_all();
			animation_player.play("captain_front")
	if direction == application.DIRECTION_LEFT:
		if previous_direction != direction:
			animation_player.play("going_left")
		apply_impulse(VECTOR_LEFT, Vector2(-self.velocity * self.mass, 0))
	if direction == application.DIRECTION_RIGHT:
		if previous_direction != direction:
			#pass
			animation_player.play("going_right")
		apply_impulse(VECTOR_RIGHT, Vector2(self.velocity * self.mass, 0))

	previous_direction = direction
	
func get_is_player():
	return is_player
	
func _ready():
	animation_player = get_node("AnimSprite").get_node("AnimationPlayer")
	animation_player.stop_all()
	
	application = get_node("/root/application")
	ai.set_character(self)
	set_fixed_process(true)
	
func _fixed_process(delta):
	var decision = ai.make_decision()
	run(decision)
	
func is_dead():
	return get_pos().y > application.get_height()

func set_ai(ai):
	self.ai = ai
	
func set_velocity(velocity):
	self.velocity = velocity

func set_is_player(is_player):
	self.is_player = is_player
