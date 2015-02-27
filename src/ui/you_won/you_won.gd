extends Node2D

func _ready():
	var application = get_node("/root/application")
	var stars = application.get_level_manager().get_current_level().get_stars()
	var text
	if (stars == 1):
		text = '1 star!'
	else:
		text = str(stars) + ' stars!'
	get_node("stars_label").set_text(text)
