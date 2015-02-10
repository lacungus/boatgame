extends RigidBody2D

const VECTOR_LEFT = Vector2(-1, 0)
const VECTOR_RIGHT = Vector2(1, 0)

# Make decision each DECISION_INTERVAL_MILLISECONDS milliseconds
const DECISION_INTERVAL_MILLISECONDS = 2000

# TODO rename
# velocity? max_speed? strength?
var speed

# true - played by user
# false - AI
var is_player = false

# Last decision was made at last_decision_timestamp since start
var last_decision_timestamp = null

# application.LEFT or application.RIGHT
var current_direction = null

var application

func set_is_player(is_player):
	self.is_player = is_player

func get_is_player():
	return self.is_player

func set_speed(speed):
	self.speed = speed
	
func run(direction):
	if direction == application.DIRECTION_LEFT:
		apply_impulse(VECTOR_LEFT, Vector2(-self.speed, 0))
		return
	if direction == application.DIRECTION_RIGHT:
		apply_impulse(VECTOR_RIGHT, Vector2(self.speed, 0))
		return
	print("Unknown direction: " + direction)
	
func run_left():
	run(application.DIRECTION_LEFT)

func run_right():
	run(application.DIRECTION_RIGHT)

func _ready():
	application = get_node("/root/application")
	set_process(true)
	
func _process(delta):
	if is_player:
		#TODO move logic from main.gd here
		return

	#TODO stop if game is not active
	
	var current_timestamp = OS.get_ticks_msec()
	if last_decision_timestamp == null || current_timestamp > last_decision_timestamp + DECISION_INTERVAL_MILLISECONDS:
		current_direction = make_decision()
		last_decision_timestamp = current_timestamp
	
	run(current_direction)
	
func make_decision():
	if current_direction == null:
		return application.DIRECTION_LEFT
	return application.opposite_direction(current_direction)

func is_dead():
	return get_pos().y > application.get_height()
