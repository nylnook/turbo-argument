extends Node2D

onready var credits = get_node("CanvasLayer/Credits")
onready var credits_button = get_node("CanvasLayer/Config/CreditsTextureButton")
var config_up = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func config_toogle():
	var config_anim = get_node("ConfigAnimationPlayer")
	var lang_button = get_node("CanvasLayer/Config/LangTextureButton")
	var music_button = get_node("CanvasLayer/Config/MusicTextureButton")
	var current_lang = TranslationServer.get_locale()
	if current_lang == "fr":
		lang_button.pressed = true
	else:
		lang_button.pressed = false
	if music.is_mute():
		music_button.pressed = true
	else:
		music_button.pressed = false
	if config_up == false:
		config_anim.play("config_up")
		config_up = true
	elif config_up == true:
		config_anim.play("config_down")
		config_up = false

func _on_ConfigTextureButton_pressed():
	config_toogle()

func _on_Config_mouse_exited():
	config_toogle()
	

func _on_MusicTextureButton_toggled( pressed ):
	if pressed == true:
		music.stop()
		music.mute()
	else:
		music.unmute()
		music.play()


func _on_CreditsTextureButton_toggled( pressed ):
	if pressed == true:
		credits.show()
	else:
		credits.hide()

func _on_CloseTextureButton_pressed():
	credits.hide()
	credits_button.pressed = false

func _on_FullscreenTextureButton_toggled( pressed ):
	if pressed == true:
		OS.set_window_fullscreen( true )
	elif OS.is_window_fullscreen() and pressed == false:
		OS.set_window_fullscreen( false )
		
func _on_LangTextureButton_toggled( pressed ):
	if pressed == true:
		TranslationServer.set_locale("fr")
	else:
		TranslationServer.set_locale("en")

func quit_game():
	get_tree().quit()

func _on_QuitTextureButton_pressed():
	quit_game()

func _input(event):
	if (event.is_action("ui_cancel") && event.is_pressed() && !event.is_echo()):
		config_toogle()
	if (event.is_action("quit") && event.is_pressed() && !event.is_echo()):
		quit_game()
	if (event.is_action("fullscreen") && event.is_pressed() && !event.is_echo()):
		var fullscreen_button = get_node("CanvasLayer/Config/FullscreenTextureButton")
		if OS.is_window_fullscreen():
			OS.set_window_fullscreen( false )
			fullscreen_button.pressed = false
		else:
			OS.set_window_fullscreen( true )
			fullscreen_button.pressed = true
	if (event.is_action("credits") && event.is_pressed() && !event.is_echo()):
		if credits.is_visible():
			credits.hide()
			credits_button.pressed = false
		else:
			credits.show()
			credits_button.pressed = true
	if (event.is_action("music") && event.is_pressed() && !event.is_echo()):
		var music_button = get_node("CanvasLayer/Config/MusicTextureButton")
		if music.is_playing():
			music.stop()
			music_button.pressed = true
		else:
			music.play()
			music_button.pressed = false


