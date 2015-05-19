var application

var current_scene = null

func _init(application):
	self.application = application
	var root = application.get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)

func goto_scene(scene, destroy_previous_scene):
	call_deferred("_deferred_goto_scene", scene, destroy_previous_scene)

func _deferred_goto_scene(scene, destroy_previous_scene):
	if current_scene != null:
		current_scene.queue_free()
		if destroy_previous_scene:
			# remove current scene from root and enqueue it for deletion
			# (when deleted, it will be removed)
			current_scene.remove_and_skip()

	# load and add new scene to root
	var s = ResourceLoader.load(scene)
	current_scene = s.instance()
	current_scene.print_tree();
	application.get_tree().get_root().add_child(current_scene)
	
func goto_next_level():
	current_scene.queue_free()
	
	current_scene = application.get_level_manager().get_next_level()
	if current_scene != null:
		application.get_tree().get_root().add_child(current_scene)
	else:
		goto_game_completed()

func goto_level(index):
	current_scene.queue_free()
	
	current_scene = application.get_level_manager().get_level(index, true)
	application.get_tree().get_root().add_child(current_scene)

func restart_level():
	call_deferred("_deferred_restart_level")

func _deferred_restart_level():
	current_scene.free()

	current_scene = application.get_level_manager().clone_current_level()
	application.get_tree().get_root().add_child(current_scene)

func goto_you_won():
	goto_scene("res://scenes/ui/you_won.xml", true)

func goto_game_completed():
	goto_scene("res://scenes/ui/game_completed.xml", true)

func goto_you_lost():
	goto_scene("res://scenes/ui/you_lost.xml", true)

func goto_in_level_menu():
	goto_scene("res://scenes/ui/in_level_menu.xml", false)

func goto_levels_menu():
	goto_scene("res://scenes/ui/levels_menu.xml", false)

func goto_main_menu():
	goto_scene("res://scenes/ui/main_menu.xml", false)
