extends Node2D

# preload next scenes
onready var bearscene = get_node("/root/global").preload_scene("res://man/bear.tscn")
onready var furyscene = get_node("/root/global").preload_scene("res://woman/fury.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if get_node("/root/music").changed:
		get_node("/root/music").base_music()


func _on_ManButton_pressed():
	get_node("repeat-tuto").hide()
	get_node("intro").choose_man()


func _on_WomanButton_pressed():
	get_node("repeat-tuto").hide()
	get_node("intro").choose_woman()
