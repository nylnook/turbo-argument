extends Node2D


func _ready():
	# Immediatly switch to french at startup if detected
	if "fr" in OS.get_locale():
		TranslationServer.set_locale("fr")
	# Allow reponsive window on the web
	if OS.get_name() == "HTML5":
		OS.set_window_maximized(true)


func _on_startmenu_hide():
	var tuto = get_node("tuto")
	var tuto_fade = tuto.get_node("FadeAnimation")
	tuto.show()
	tuto_fade.play("fade")