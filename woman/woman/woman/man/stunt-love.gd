extends Node2D

# animation vars
onready var curtain = get_node("curtain")
onready var intro_woman = get_node("IntroWoman")
onready var intro_man = get_node("IntroMan")
onready var woman = get_node("Woman")
onready var man = get_node("Man")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("/root/music").happy_music()
	intro_woman.play()
	intro_man.play()



func _on_IntroWoman_animation_finished():
	intro_woman.hide()
	intro_man.hide()
	woman.show()
	man.show()
	woman.play()
	man.play()
