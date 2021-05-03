extends Control


signal _on_finished_request

onready var username: LineEdit = find_node('usernameLineEdit')
onready var password: LineEdit = find_node('PasswordLineEdit')
onready var signinButton: TextureButton = find_node('signinButton')
onready var popup: Control = find_node('popup')


func _ready():
	self.connect("_on_finished_request", self, "_on_finished_request_func")

func _on_backButton_button_up():
	Global.back_scene()

func _on_signupButton_button_up():
	Global.goto_scene(Global.signup_scene)

func _on_signinButton_button_up():
	if username.text and password.text:
		var data = {
			"username": username.text,
			"password": password.text
		}
		data = JSON.print(data)
		signinButton.disabled = true
		Request.send_request(data, Request.signin, {"node": self})

func _on_finished_request_func(data: Dictionary):
	if data["response_code"] == 200:
		Global.save_user_data(data['body'])
		username.text = ''
		password.text = ''
		Global.popup_scene.popup('Welcome', "welcome %s. you successfully signed in." % data['body']['username'])
		Global.main_scene.emit_signal('change_signin_button_text')
		Global.back_scene()
	elif data["response_code"] == 400 or data["response_code"] == 404 or data["response_code"] == 401:
		if 'message' in data['body']:
			Global.popup_scene.popup('error', data['body']['message'])
		elif typeof(data['body']) == TYPE_ARRAY and 'message' in data['body'][0]:
			Global.popup_scene.popup('error', data['body'][0]['message'])
		else:
			Global.popup_scene.popup('error', 'Signin was not successful')
	signinButton.disabled = false
