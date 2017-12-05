extends Node2D

# animation vars
onready var button_man = get_node("Button_man")
onready var button_woman = get_node("Button_woman")
onready var repeat_tuto = get_node("repeat-tuto")
onready var are_you_crazy_man = get_node("AreYouCrazy_Man")
onready var are_you_crazy_dragon = get_node("AreYouCrazy_Dragon")
onready var man_wait = get_node("Man_wait")
onready var dragon_you_are_not = get_node("Dragon_you_are_not")
onready var timer1 = get_node("Timer1")
onready var frame1 = get_node("Timer1/Frame1")
onready var timer2 = get_node("Timer2")
onready var frame2 = get_node("Timer2/Frame2")
onready var timer3 = get_node("Timer3")
onready var frame3 = get_node("Timer3/Frame3")
onready var timer4 = get_node("Timer4")
onready var timer5 = get_node("Timer5")
onready var discover_bg = get_node("Timer5/DiscoverThePain_bg")
onready var discover = get_node("Timer5/DiscoverThePain")
onready var curtain = get_node("Timer5/curtain")
onready var timer6 = get_node("Timer6")
onready var touch = get_node("Timer6/TouchThePain")
onready var blow = get_node("BlowThePain")


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


func choose_woman():
	# hide buttons to avoid second click
	button_woman.hide()
	button_man.hide()
	# hide tuto
	repeat_tuto.hide()
	# play animations
	are_you_crazy_man.hide()
	are_you_crazy_dragon.hide()
	man_wait.show()
	dragon_you_are_not.show()
	dragon_you_are_not.play()

func _on_Dragon_you_are_not_animation_finished():
	# back to original state
	man_wait.hide()
	dragon_you_are_not.hide()
	dragon_you_are_not.stop()
	dragon_you_are_not.set_frame(0)
	are_you_crazy_man.set_frame(0)
	are_you_crazy_dragon.set_frame(0)
	are_you_crazy_man.show()
	are_you_crazy_dragon.show()
	# stop and reset repeat tuto fade animation
	var repeat_tuto_fade = get_node("repeat-tuto/FadePlayer")
	# only way to reset properly : stop and go to the end
	repeat_tuto_fade.stop()
	repeat_tuto_fade.seek(7, true)
	# show and start
	repeat_tuto.show()
	repeat_tuto_fade.play("fade")
	# show buttons again
	button_woman.show()
	button_man.show()


func choose_man():
	# hide buttons to avoid second click
	button_woman.hide()
	button_man.hide()
	# preload next scene
	get_node("/root/global").preload_interactive_next_scene("res://woman/woman/woman/man/stunt-love.tscn")
	# hide tuto
	get_node("repeat-tuto").hide()
	# play animations
	are_you_crazy_man.stop()
	are_you_crazy_man.set_frame(0)
	frame1.show()
	timer1.play("frame1")


func _on_Timer1_animation_finished( name ):
	are_you_crazy_dragon.stop()
	are_you_crazy_dragon.set_frame(0)
	frame2.show()
	timer2.play("frame2")


func _on_Timer2_animation_finished( name ):
	frame3.show()
	timer3.play("frame3")


func _on_Timer3_animation_finished( name ):
	var newbg = get_node("newbg")
	newbg.show()
	frame1.hide()
	frame2.hide()
	frame3.hide()
	curtain.show()
	timer4.play("frame4")
	

func _on_Timer4_animation_finished( name ):
	timer5.play("frame5")
	discover_bg.show()
	discover.show()

func _on_Timer5_animation_finished( name ):
	touch.show()
	timer6.play("frame6")
	curtain.hide()
	discover.hide()
	
func _on_Timer6_animation_finished( name ):
	discover_bg.hide()
	touch.hide()
	blow.show()
	blow.play()


func _on_BlowThePain_animation_finished():
	# go to stunt love scene
	get_node("/root/global").goto_next_scene()



