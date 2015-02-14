#TODO set application here
class BaseAI:
	var character
	
	func set_character(character):
		self.character = character

class PlayerAI:
	extends BaseAI
	
	var application
	func _init(application):
		self.application = application
	
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
	
	var application
	
	func _init(application):
		self.application = application
	
	func make_decision():
		var current_timestamp = OS.get_ticks_msec()
		if last_decision_timestamp != null && current_timestamp < last_decision_timestamp + DECISION_INTERVAL_MILLISECONDS:
			return current_direction

		if current_direction == null:
			current_direction = application.DIRECTION_LEFT
		else:
			current_direction = application.opposite_direction(current_direction)

		last_decision_timestamp = current_timestamp
		return current_direction

class FollowingAI:
	extends BaseAI

	var application
	
	func _init(application):
		self.application = application
		
	func make_decision():
		var player = application.get_level_manager().get_current_level().get_player()

		if (player.get_pos().x < character.get_pos().x):
			return application.DIRECTION_LEFT
		
		if (player.get_pos().x > character.get_pos().x):
			return application.DIRECTION_RIGHT
		
		return null
