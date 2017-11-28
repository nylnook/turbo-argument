extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_StartButton_pressed():
	self.hide()
	
func _input(event):
	if (event.is_action("ui_accept") && event.is_pressed() && !event.is_echo()):
		self.hide()


func _on_FrenchButton_pressed():
	TranslationServer.set_locale("fr")


func _on_EnglishButton_pressed():
	TranslationServer.set_locale("en")
