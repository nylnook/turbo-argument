extends Node2D

# animation vars
onready var button_man = get_node("Button_man")
onready var button_woman = get_node("Button_woman")
onready var Anim_intro_man = get_node("Anim_intro_man")
onready var Anim_intro_woman = get_node("Anim_intro_woman")
onready var Anim_transition_bear_man = get_node("Anim_transition_bear_man")
onready var Anim_transition_bear_woman = get_node("Anim_transition_bear_woman")
onready var Anim_transition_fury_man = get_node("Anim_transition_fury_man")
onready var Anim_transition_fury_woman = get_node("Anim_transition_fury_woman")
onready var parent = get_parent()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _on_Button_man_pressed():
	choose_man()

func _on_Button_woman_pressed():
	choose_woman()

func _input(event):
	if (event.is_action("choose_man") && event.is_pressed() && !event.is_echo()):
		choose_man()
	if (event.is_action("choose_woman") && event.is_pressed() && !event.is_echo()):
		choose_woman()


func choose_man():
	# hide buttons to avoid second click
	button_woman.hide()
	button_man.hide()
	# preload next scene
	get_node("/root/global").preload_interactive_next_scene("res://man/bear.tscn")
	# play animations
	Anim_intro_man.hide()
	Anim_intro_woman.hide()
	if parent.has_node("tuto"):
		parent.get_node("tuto").hide()
	Anim_transition_bear_man.show()
	Anim_transition_bear_woman.show()
	Anim_transition_bear_man.play("default")
	Anim_transition_bear_woman.play("default")

func _on_Anim_transition_bear_man_animation_finished():
	# go to bear scene
	get_node("/root/global").goto_next_scene()
	
func choose_woman():
	# hide buttons to avoid second click
	button_woman.hide()
	button_man.hide()
	# preload next scene
	get_node("/root/global").preload_interactive_next_scene("res://woman/fury.tscn")
	# play animations
	Anim_intro_man.hide()
	Anim_intro_woman.hide()
	if parent.has_node("tuto"):
		parent.get_node("tuto").hide()
	Anim_transition_fury_man.show()
	Anim_transition_fury_woman.show()
	Anim_transition_fury_man.play("default")
	Anim_transition_fury_woman.play("default")
	
func _on_Anim_transition_fury_woman_animation_finished():
	# go to fury scene
	get_node("/root/global").goto_next_scene()


