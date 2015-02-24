#TODO set application here
class BaseAI:
	var character
	var application
	var delta
	var boat_delta
	
	func init(application):
		self.application = application
		
		delta = application.get_width()/100
		boat_delta = application.get_width()/3
		
		
	func set_character(character):
		self.character = character
		
	func get_center_of_mass():
		var level = application.get_level_manager().get_current_level()
		
		var sum_x = 0
		var sum_y = 0
		var sum_mass = 0
		var i = 0
		var characters = level.get_characters()
		
		while i < characters.size():
			var character = characters[i]
			i = i + 1			
			sum_x = sum_x + character.mass * character.get_pos().x
			sum_y = sum_x + character.mass * character.get_pos().y
			sum_mass = sum_mass + character.mass
		
		return Vector2(sum_x / sum_mass, sum_y / sum_mass)

class PlayerAI:
	extends BaseAI
	
	func _init(application):
		init(application)
	
	func make_decision():
		if (application.is_left_active()):
			return "left"
	
		if (application.is_right_active()):
			return "right"
			
		return null

class SwingingAI:
	extends BaseAI

		# Make decision each DECISION_INTERVAL_MILLISECONDS milliseconds
	const DECISION_INTERVAL_MILLISECONDS = 2000
	
	var current_direction
	var last_decision_timestamp
	
	func _init(application):
		init(application)
	
	func make_decision():
		var current_timestamp = OS.get_ticks_msec()
		if last_decision_timestamp != null && current_timestamp < last_decision_timestamp + DECISION_INTERVAL_MILLISECONDS:
			return current_direction

		if current_direction == null:
			if character.get_pos().x > boat_delta:
				current_direction = application.DIRECTION_LEFT
			else: 
				current_direction = application.DIRECTION_RIGHT
		else:
			if (character.get_pos().x > boat_delta && character.get_pos().x < application.get_width()-boat_delta):
				current_direction = application.opposite_direction(current_direction)
			else:
				if character.get_pos().x > boat_delta:
					current_direction = application.DIRECTION_LEFT
				else:
					current_direction = application.DIRECTION_RIGHT
				

		last_decision_timestamp = current_timestamp
		return current_direction

class FollowingAI:
	extends BaseAI

	func _init(application):
		init(application)
	
	func make_decision():
		var player = application.get_level_manager().get_current_level().get_player()

		if (player.get_pos().x + delta < character.get_pos().x && character.get_pos().x > boat_delta):
			return application.DIRECTION_LEFT
		
		if (player.get_pos().x - delta > character.get_pos().x && character.get_pos().x < application.get_width() - boat_delta):
			return application.DIRECTION_RIGHT
		
		return null

class BalancingAI:
	extends BaseAI

	func _init(application):
		init(application)
	
	
	func make_decision():
		var center_of_mass = get_center_of_mass()
		

		if (center_of_mass.x < (application.get_width() / 2 - delta) && character.get_pos().x < (application.get_width() - boat_delta)):
			return application.DIRECTION_RIGHT
		
		if (center_of_mass.x > (application.get_width() / 2 + delta) && character.get_pos().x > boat_delta) :
			return application.DIRECTION_LEFT
		
		return null

