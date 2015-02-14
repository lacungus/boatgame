var application

var current_scene = null

func _init(application):
	self.application = application
	var root = application.get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)

func goto_scene(scene):
	# remove current scene from root and enqueue it for deletion
	# (when deleted, it will be removed)
	current_scene.queue_free()

	# load and add new scene to root
	var s = ResourceLoader.load(scene)
	current_scene = s.instance()
	application.get_tree().get_root().add_child(current_scene)
	
func goto_main():
	goto_scene("res://main.xml")

func goto_next_level():
	current_scene = application.get_level_manager().get_next_level()
	application.get_tree().get_root().add_child(current_scene)
