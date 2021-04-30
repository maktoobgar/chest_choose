extends Node


enum BoxStates {NOTOPENED, OPENED, LOCKED}

onready var root: Node = get_tree().root.get_child(1)
onready var player: KinematicBody2D = root.get_node_or_null('player')
onready var chests: Node2D = root.get_node_or_null('chests')
onready var hint: HBoxContainer = root.get_node_or_null('cameraCanvas/hint')
onready var scroll: Control = root.get_node_or_null('cameraCanvas/scroll')
onready var ui: Control = root.get_node_or_null('cameraCanvas/ui')
onready var mouse: Node2D = root.get_node_or_null('cameraCanvas/mouse')
onready var main_scene: Control = root.get_node_or_null('main')
onready var signin_scene: Control = root.get_node_or_null('signin')
onready var signup_scene: Control = root.get_node_or_null('signup')
onready var current_scene: Control = main_scene
var back: Array = []

func back_scene():
	hidden_all()
	var scene = back.pop_back()
	current_scene = scene
	scene.visible = true

func goto_scene(scene: Control = main_scene):
	hidden_all()
	back.push_back(current_scene)
	current_scene = scene
	scene.visible = true

func hidden_all():
	main_scene.visible = false
	signin_scene.visible = false
	signup_scene.visible = false
