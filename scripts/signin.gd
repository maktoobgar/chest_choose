extends Control


func _on_backButton_button_up():
	Global.back_scene()

func _on_signupButton_button_up():
	Global.goto_scene(Global.signup_scene)
