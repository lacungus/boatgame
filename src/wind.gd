extends Node2D

var amplitude
var period

var application

func _init(application, amplitude, period):
	self.amplitude = amplitude
	self.period = period
	self.application = application

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	var level = application.get_level_manager().get_current_level()
	var wind_strength = get_strength(level.get_time_passed())
	var res
	
	if wind_strength < -10:
		application.set_x(get_node("/root/Game/main_layer/wind_asset"), application.get_width() * 5/6)
		res = load("res://assets/wind/wind_left.png")
		
	if wind_strength < -3 && wind_strength > -10:
		application.set_x(get_node("/root/Game/main_layer/wind_asset"), application.get_width() * 2/3)
		res = load("res://assets/wind/wind_left2.png")
	
	if wind_strength > -3 && wind_strength < 3:
		application.set_x(get_node("/root/Game/main_layer/wind_asset"), application.get_width() * 1/2)
		res = load("res://assets/wind/center.png")
		
	if wind_strength > 3 && wind_strength < 10:
		application.set_x(get_node("/root/Game/main_layer/wind_asset"), application.get_width() * 1/3)
		res = load("res://assets/wind/wind_right2.png")
		
	if wind_strength > 10:
		application.set_x(get_node("/root/Game/main_layer/wind_asset"), application.get_width() * 1/6)
		res = load("res://assets/wind/wind_right.png")
		
	get_node("/root/Game/main_layer/wind_asset").set_texture(res)
	get_node("/root/Game/ui_layer/wind_label").set_text(str(int(ceil(wind_strength))))
	
	for character in level.get_characters():
		character.apply_impulse(application.direction.VECTOR_LEFT, Vector2(wind_strength, 0))

# PRIVATE

func get_strength(t):
	return amplitude * t * sin(period * t)
