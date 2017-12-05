extends Node2D

# animation vars
onready var button_man = get_node("Button_man")
onready var button_woman = get_node("Button_woman")
onready var anim_bear_woman = get_node("Anim_bear_woman")
onready var anim_bear_man = get_node("Anim_bear_man")
onready var kill_bear_woman = get_node("Kill_bear_woman")
onready var kill_bear_man = get_node("Kill_bear_man")
onready var kill_bear_woman_wait = get_node("Kill_bear_woman_wait")


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
	get_node("/root/global").preload_interactive_next_scene("res://man/man/lonely_bear.tscn")
	# hide tuto
	get_node("repeat-tuto").hide()
	# play animations
	var crazy_bear_anim_in = get_node("CrazyBearInAnimation")
	crazy_bear_anim_in.play("CrazyBearIn")


func _on_CrazyBearInAnimation_animation_finished( name ):
	var crazy_bear_in = get_node("Crazy_bear_bg/Crazy_bear_in")
	var crazy_bear = get_node("Crazy_bear_bg/Crazy_bear")
	var woman_bg = get_node("Woman_bg")
	var woman_fear = get_node("Woman_bg/Woman_fear")
	crazy_bear_in.hide()
	crazy_bear.show()
	woman_bg.show()
	woman_fear.play()


func _on_Woman_fear_animation_finished():
	var woman_fear = get_node("Woman_bg/Woman_fear")
	var woman_run = get_node("Woman_bg/Woman_run")
	woman_fear.hide()
	woman_run.show()
	woman_run.play()
	


func _on_Woman_run_animation_finished():
	var woman_bg = get_node("Woman_bg")
	var crazy_bear_bg = get_node("Crazy_bear_bg")
	var crazy_bear_end = get_node("Crazy_bear_end")
	anim_bear_woman.hide()
	anim_bear_man.hide()
	woman_bg.hide()
	crazy_bear_bg.hide()
	crazy_bear_end.show()
	crazy_bear_end.play()
	

func _on_Crazy_bear_end_animation_finished():
	# go to lonely bear scene
	get_node("/root/global").goto_next_scene()


func choose_woman():
	# hide buttons to avoid second click
	button_woman.hide()
	button_man.hide()
	# preload next scene
	get_node("/root/global").preload_interactive_next_scene("res://man/woman/lonely-woman.tscn")
	# hide tuto
	get_node("repeat-tuto").hide()
	# play animations
	anim_bear_woman.hide()
	kill_bear_woman.show()
	kill_bear_woman.play()


func _on_Kill_bear_woman_animation_finished():
	var background = get_node("background/background")
	kill_bear_woman.hide()
	background.hide()
	kill_bear_woman_wait.show()
	anim_bear_man.hide()
	kill_bear_man.show()
	kill_bear_man.play()
	


func _on_Kill_bear_man_animation_finished():
	var kill_bear_timer = get_node("KillBearTimer")
	var kill_bear_man_2 = get_node("Kill_bear_man_2")
	var kill_bear_man_in = get_node("KillBearInAnimation")
	kill_bear_man.hide()
	kill_bear_timer.play("KillBearTimer")
	kill_bear_man_in.play("KillBearIn")
	kill_bear_man_2.play()


func _on_KillBearTimer_animation_finished( name ):
	var kill_bear_woman_2 = get_node("Kill_bear_woman_2")
	kill_bear_woman_wait.hide()
	kill_bear_woman_2.show()
	kill_bear_woman_2.play()


func _on_Kill_bear_man_2_animation_finished():
	# go to lonely woman scene
	get_node("/root/global").goto_next_scene()
