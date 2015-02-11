class PlayerAI:
	func make_decision():
		if (Input.is_action_pressed("ui_left")):
			return "left"
	
		if (Input.is_action_pressed("ui_right")):
			return "right"
			
		return null

class SwingingAI:
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
