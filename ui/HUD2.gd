extends Node2D

# preload next scenes
# onready var restartscene = get_node("/root/global").preload_scene("res://restart.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func retry():
	get_node("/root/global").goto_scene("res://restart.tscn")


func _input(event):
	if (event.is_action("retry") && event.is_pressed() && !event.is_echo()):
		retry()


func _on_SmallRetry_pressed():
	retry()
