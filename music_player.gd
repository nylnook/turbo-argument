extends AudioStreamPlayer

var music
var changed
var mute = false

func _ready():
	base_music()
	
func base_music():
	changed = false
	music = load("res://sounds/Stoneworld Battle mono.ogg")
	self.set_stream(music)
	if mute == false:
		self.play()
	
func happy_music():
	changed = true
	music = load("res://sounds/Carpe Diem mono.ogg")
	self.set_stream(music)
	if mute == false:
		self.play()
		
func mute():
	mute = true
	
func unmute():
	mute = false
	
func is_mute():
	if mute == true:
		return true