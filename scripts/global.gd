extends Node


enum BoxStates {NOTOPENED, OPENED, LOCKED}

const user_data: String = "user://userdata.save"

var root: Node
var player: KinematicBody2D
var chests: Node2D
var hint: HBoxContainer
var scroll: Control
var ui: Control
var mouse: Node2D
var main_scene: Control
var signin_scene: Control
var signup_scene: Control
var popup_scene: Control
var current_scene: Control
var back: Array = []

#user_data
var username: String = ""
var email: String = ""
var token: String = ""

func _ready() -> void:
	root = get_tree().root.get_child(2)
	player = root.get_node_or_null('player')
	chests = root.get_node_or_null('chests')
	hint = root.get_node_or_null('cameraCanvas/hint')
	scroll = root.get_node_or_null('cameraCanvas/scroll')
	ui = root.get_node_or_null('cameraCanvas/ui')
	mouse = root.get_node_or_null('cameraCanvas/mouse')
	main_scene = root.get_node_or_null('main')
	signin_scene = root.get_node_or_null('signin')
	signup_scene = root.get_node_or_null('signup')
	popup_scene = root.get_node_or_null('popup')
	current_scene = main_scene
	back = []
	username = ""
	email = ""
	token = ""
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
