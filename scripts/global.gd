extends Node


enum BoxStates {NOTOPENED, OPENED, LOCKED}

const user_data: String = "user://userdata.save"

onready var root: Node = get_tree().root.get_child(2)
onready var player: KinematicBody2D = root.get_node_or_null('player')
onready var chests: Node2D = root.get_node_or_null('chests')
onready var hint: HBoxContainer = root.get_node_or_null('cameraCanvas/hint')
onready var scroll: Control = root.get_node_or_null('cameraCanvas/scroll')
onready var ui: Control = root.get_node_or_null('cameraCanvas/ui')
onready var mouse: Node2D = root.get_node_or_null('cameraCanvas/mouse')
onready var main_scene: Control = root.get_node_or_null('main')
onready var signin_scene: Control = root.get_node_or_null('signin')
onready var signup_scene: Control = root.get_node_or_null('signup')
onready var popup_scene: Control = root.get_node_or_null('popup')
onready var current_scene: Control = main_scene
var back: Array = []

#user_data
var username: String = ""
var email: String = ""
var token: String = ""

func _ready() -> void:
	load_user_data()

func back_scene() -> void:
	hidden_all()
	var scene = back.pop_back()
	current_scene = scene
	scene.visible = true

func goto_scene(scene: Control = main_scene) -> void:
	hidden_all()
	back.push_back(current_scene)
	current_scene = scene
	scene.visible = true

func clear_back() -> void:
	back = []

func hidden_all() -> void:
	main_scene.visible = false
	signin_scene.visible = false
	signup_scene.visible = false

func save_user_data(data: Dictionary = {}) -> void:
	var file = File.new()
	file.open(user_data, File.WRITE)
	file.store_line(to_json(data))
	file.close()
	load_user_data_to_game(data)

func load_user_data_to_game(data: Dictionary = {}) -> void:
	username = data['username']
	email = data['email']
	token = data['token']

func load_user_data() -> bool:
	var file = File.new()
	if file.file_exists(user_data):
		file.open(user_data, File.READ)
		var data = parse_json(file.get_line())
		if not data:
			signout()
			return false
		load_user_data_to_game(data)
		return true
	return false

func signout() -> void:
	username = ''
	email = ''
	token = ''
	var file = File.new()
	if file.file_exists(user_data):
		var dir = Directory.new()
		dir.remove(user_data)

func data_exist() -> bool:
	if not token:
		return false
	return true
