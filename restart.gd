extends Node2D

# animation vars
onready var button_man = get_node("Button_man")
onready var button_woman = get_node("Button_woman")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if get_node("/root/music").changed:
		get_node("/root/music").base_music()


func _on_ManButton_pressed():
	# hide buttons to avoid second click
	button_woman.hide()
	button_man.hide()
	# play intro
	get_node("repeat-tuto").hide()
	get_node("intro").choose_man()


func _on_WomanButton_pressed():
	# hide buttons to avoid second click
	button_woman.hide()
	button_man.hide()
	# play intro
	get_node("repeat-tuto").hide()
	get_node("intro").choose_woman()
