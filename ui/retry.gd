extends Node2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_RetryButton_pressed():
	 get_node("/root/global").retry()
	
func _input(event):
	if (event.is_action("retry") && event.is_pressed() && !event.is_echo()):
		get_node("/root/global").retry()
	if (event.is_action("ui_accept") && event.is_pressed() && !event.is_echo()):
		get_node("/root/global").retry()
