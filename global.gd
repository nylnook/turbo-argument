extends Node

var current_scene = null
var next_scene = null
var loader
var time_max = 100 # msec
var wait_frames
onready var restart_scene = ResourceLoader.load("res://restart.tscn")

func _ready():
	# define current scene
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	

# prefered way : preload next scene interactively when animation start, go to when animation finish
func preload_interactive_next_scene(path):
	
	# Preload new scene
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		# show errors
		show_error()
		return
	set_process(true)
	
	wait_frames = 1

func _process(time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	if wait_frames > 0: # wait for frames to let the "loading" animation to show up
		wait_frames -= 1
		return

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control how much time we block this thread
	
		# poll your loader
		var err = loader.poll()
		
		if err == ERR_FILE_EOF: # load finished
			next_scene = loader.get_resource()
			loader = null
			# set_new_scene(resource)
			break
		elif err == OK:
			update_progress()
		else: # error during loading
			show_error()
			loader = null
			break

func update_progress():
	var progress = (float(loader.get_stage()) / loader.get_stage_count())*100
	var progressbar = current_scene.get_node("HUD/DebugLoadProgressBar")
	#print(progress)
	#print(progressbar)
	#print(progressbar.percent_visible)
	# update progress bar
	progressbar.set_value(progress)
	
func show_error():
	print(loader)
	print(wait_frames)



# or preload next scene non interactively when animation start, go to when animation finish
func preload_next_scene(path):
	
	# Preload new scene
	next_scene = ResourceLoader.load(path)
	return next_scene

# shared
func goto_next_scene():
	
	# /!\ Works only if scene has been preloaded
	# print(next_scene)
	call_deferred("_deferred_goto_next_scene")
	
func _deferred_goto_next_scene():

	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()
	
	# Instance the new scene
	current_scene = next_scene.instance()
	
	# empty the no more useful next scene
	next_scene = null
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene(current_scene)




# way to preload a scene non interactively in a var to allow multiple preloads
func preload_scene(path):
	
	# Preload new scene
	var s = ResourceLoader.load(path)
	return s

func goto_preload_scene(s):
	
	# /!\ Works only if scene has been preloaded
	# print(s)
	call_deferred("_deferred_goto_preload_scene",s)

func _deferred_goto_preload_scene(s):

	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()
	
	# print(s)
	# Instance the new scene
	current_scene = s.instance()
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene(current_scene)




# directly load a scene
func goto_scene(path):
	
	# This function will usually be called from a signal callback,
	# or some other function from the running scene.
	# Deleting the current scene at this point might be
	# a bad idea, because it may be inside of a callback or function of it.
	# The worst case will be a crash or unexpected behavior.
	
	# The way around this is deferring the load to a later time, when
	# it is ensured that no code from the current scene is running:
	
	call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):

	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()
	
	# Load new scene
	var s = ResourceLoader.load(path)
	
	# Instance the new scene
	current_scene = s.instance()
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene(current_scene)
	
	
# retry and go to restart
func retry():
	
	# This function will usually be called from a signal callback,
	# or some other function from the running scene.
	# Deleting the current scene at this point might be
	# a bad idea, because it may be inside of a callback or function of it.
	# The worst case will be a crash or unexpected behavior.
	
	# The way around this is deferring the load to a later time, when
	# it is ensured that no code from the current scene is running:
	
	call_deferred("_deferred_retry")

func _deferred_retry():

	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()
	
	# Instance the restart scene
	current_scene = restart_scene.instance()
	
	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene(current_scene)