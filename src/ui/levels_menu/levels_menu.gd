extends Node2D

const BUTTON_WIDTH = 150
const BUTTON_HEIGHT = 150

var application 

func _ready():
	application = get_node("/root/application")
	
	for i in range(application.get_level_manager().get_level_count()):
		var stars = application.get_level_manager().get_stars(i + 1)
		var button = Button.new()
		button.set_custom_minimum_size(Vector2(BUTTON_WIDTH, BUTTON_HEIGHT))
		button.set_text("Level " + str(i + 1) + ". " + star_message(stars))
		button.connect("pressed", self, "on_button_clicked", [i + 1])
		button.set_stop_mouse(true)
		get_node("ScrollContainer/levels_bar").add_child(button)

	pass

func star_message(stars):
	if stars == null:
		return "Not completed."
	return str(stars) + " stars."

func on_button_clicked(index):
	application.get_scene_manager().goto_level(index)
	