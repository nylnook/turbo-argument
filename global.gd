extends Node

var current_scene = null
var next_scene = null
onready var restart_scene = ResourceLoader.load("res://restart.tscn")

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	

# prefered way : preload next scene when animation start, go to when animation finish
func preload_next_scene(path):
	
	# Preload new scene
	next_scene = ResourceLoader.load(path)
	return next_scene

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

# way to preload a scene in a var to allow multiple preloads
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