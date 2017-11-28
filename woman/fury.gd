extends Node2D

# animation vars
onready var button_man = get_node("Button_man")
onready var button_woman = get_node("Button_woman")
onready var anim_fury_man = get_node("Anim_fury_man")
onready var anim_fury_woman = get_node("Anim_fury_woman")


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
	get_node("/root/global").preload_next_scene("res://woman/man/yin-yang.tscn")
	# hide tuto
	get_node("repeat-tuto").hide()
	# play animations
	var sorry_man = get_node("sorry_man")
	var sorry_woman = get_node("sorry_woman")
	var timer_sorry = get_node("Timer_sorry")
	anim_fury_man.hide()
	anim_fury_woman.hide()
	sorry_man.show()
	sorry_woman.show()
	sorry_man.play()
	sorry_woman.play()
	timer_sorry.play("timer_sorry")


func _on_Timer_sorry_animation_finished( name ):
	var curtain_player = get_node("CurtainPlayer")
	curtain_player.play("curtain")
	get_node("/root/music").happy_music()


func _on_CurtainPlayer_animation_finished( curtain ):
	var lovers_player = get_node("LoversPlayer")
	lovers_player.play("lovers")
	var timer = get_node("Timer")
	timer.play("timer")

func _on_Timer_animation_finished( name ):
	var sorry_central = get_node("sorry_central")
	sorry_central.show()
	sorry_central.play()

func _on_LoversPlayer_animation_finished( lovers ):
	var sorry_man_love = get_node("sorry_man_love")
	var sorry_woman_love = get_node("sorry_woman_love")
	sorry_man_love.hide()
	sorry_woman_love.hide()

func _on_sorry_central_animation_finished():
	var yin_yang = get_node("yin-yang")
	var yin_yang_player = get_node("YinYangPlayer")
	yin_yang.show()
	yin_yang_player.play("yin-yang")


func _on_YinYangPlayer_animation_finished( name ):
	# go to yin-yang scene
	get_node("/root/global").goto_next_scene()


func choose_woman():
	# hide buttons to avoid second click
	button_woman.hide()
	button_man.hide()
	# preload next scene
	get_node("/root/global").preload_next_scene("res://woman/woman/dragon.tscn")
	# hide tuto
	get_node("repeat-tuto").hide()
	# play animations
	var dragon_man = get_node("dragon_man")
	var dragon_woman = get_node("dragon_woman")
	anim_fury_man.hide()
	anim_fury_woman.hide()
	dragon_man.show()
	dragon_woman.show()
	dragon_man.play()
	dragon_woman.play()


func _on_dragon_woman_animation_finished():
	# go to dragon scene
	get_node("/root/global").goto_next_scene()
