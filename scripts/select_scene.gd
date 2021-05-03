extends HBoxContainer


onready var startButton: TextureButton = find_node('startButton')


func _on_startButton_button_down():
	if Global.select_character:
		get_tree().change_scene("res://scenes/levels/game.tscn")

func _on_pink_button_down():
	Global.select_character = load('res://scenes/instances/characters/pink.tscn')
	startButton.disabled = false

func _on_owlet_button_down():
	Global.select_character = load('res://scenes/instances/characters/owlet.tscn')
	startButton.disabled = false

func _on_dude_button_down():
	Global.select_character = load('res://scenes/instances/characters/dude.tscn')
	startButton.disabled = false
