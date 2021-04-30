extends Control


onready var name_label: Label = find_node('nameLabel')

func _on_quitButton_button_up():
	get_tree().quit(0)

func _on_signinButton_button_up():
	Global.goto_scene(Global.signin_scene)

func _on_startButton_button_up():
	pass # Replace with function body.
