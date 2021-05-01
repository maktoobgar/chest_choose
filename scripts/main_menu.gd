extends Control


signal change_signin_button_text

onready var signin_button: TextureButton = find_node('signinButton')
onready var signin_label: Label = signin_button.get_child(0)

func _ready():
	self.connect("change_signin_button_text", self, 'change_signin_button_text_func')
	if Global.data_exist():
		signin_label.text = 'Signout'
	else:
		signin_label.text = 'Signin'

func _on_quitButton_button_up():
	get_tree().quit(0)

func _on_signinButton_button_up():
	if signin_label.text == 'Signin':
		Global.goto_scene(Global.signin_scene)
	elif signin_label.text == 'Signout':
		Global.signout()
		signin_label.text = 'Signin'

func _on_startButton_button_up():
	get_tree().change_scene("res://scenes/levels/game.tscn")

func change_signin_button_text_func():
	if signin_label.text == 'Signin':
		signin_label.text = 'Signout'
	elif signin_label.text == 'Signout':
		signin_label.text = 'Signin'
