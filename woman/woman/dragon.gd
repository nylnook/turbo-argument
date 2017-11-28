extends Node2D

# animation vars
onready var button_man = get_node("Button_man")
onready var button_woman = get_node("Button_woman")
onready var dragon_man = get_node("DragonMan")
onready var dragon_woman = get_node("DragonWoman")
onready var man_stand = get_node("Man_stand")
onready var dragon_while_man_stand = get_node("Dragon_while_man_stand")
onready var frame_timer = get_node("Frame_Timer")
onready var frame_knight = get_node("Frame_Knight")
onready var frame_dragon = get_node("Frame_Dragon")
onready var man_princess = get_node("Man_princess")
onready var dragon_wizard = get_node("Dragon_wizard")
onready var man_invitation = get_node("Man_invitation")

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
	get_node("/root/global").preload_next_scene("res://woman/woman/man/dragon-kingdom.tscn")
	# hide tuto
	get_node("repeat-tuto").hide()
	# play animations
	dragon_man.hide()
	dragon_woman.hide()
	man_stand.show()
	dragon_while_man_stand.show()
	man_stand.play()
	dragon_while_man_stand.play()

func _on_Man_stand_animation_finished():
	frame_knight.show()

func _on_Dragon_while_man_stand_animation_finished():
	frame_dragon.show()
	frame_timer.play("timer")


func _on_Frame_Timer_animation_finished( name ):
	dragon_while_man_stand.hide()
	dragon_wizard.show()
	frame_knight.hide()
	frame_dragon.hide()
	dragon_wizard.play()


func _on_Dragon_wizard_animation_finished():
	man_stand.hide()
	man_princess.show()
	man_princess.play()


func _on_Man_princess_animation_finished():
	var fade_out = get_node("Fade_Out")
	fade_out.play("fade-out")


func _on_Fade_Out_animation_finished( name ):
	# go to dragon kingdom scene
	get_node("/root/global").goto_next_scene()


func choose_woman():
	# hide buttons to avoid second click
	button_woman.hide()
	button_man.hide()
	# preload next scene
	get_node("/root/global").preload_next_scene("res://woman/woman/woman/are-you-crazy.tscn")
	# hide tuto
	get_node("repeat-tuto").hide()
	# play animations
	var dragon_invitation = get_node("Dragon_invitation")
	dragon_man.hide()
	dragon_woman.hide()
	man_invitation.show()
	dragon_invitation.show()
	man_invitation.play()
	dragon_invitation.play()


func _on_Man_invitation_animation_finished():
	var man_invitation_stand_up = get_node("Man_invitation_stand_up")
	man_invitation.hide()
	man_invitation_stand_up.show()
	man_invitation_stand_up.play()
	


func _on_Man_invitation_stand_up_animation_finished():
	# go to "are you crazy ?" scene
	get_node("/root/global").goto_next_scene()
