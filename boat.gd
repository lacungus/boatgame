extends Node2D

var application

func _ready():
	application = get_node("/root/application")

	center()

func center():
	application.set_x(get_node("/root/Game/boat"), application.get_width() / 2)
	application.set_x(get_node("/root/Game/boat/top"), 0)
	application.set_x(get_node("/root/Game/boat/bottom"), 0)
