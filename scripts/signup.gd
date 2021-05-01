extends Control


signal _on_finished_request

onready var email: LineEdit = find_node('emailLineEdit')
onready var username: LineEdit = find_node('usernameLineEdit')
onready var password: LineEdit = find_node('passwordLineEdit')
onready var confirm_password: LineEdit = find_node('confirmPasswordLineEdit')
onready var signup_button: TextureButton = find_node('signupButton')


func _ready():
	self.connect("_on_finished_request", self, "_on_finished_request_func")

func _on_backButton_button_up():
	Global.back_scene()

func _on_signupButton_button_up():
	if not (email.text and username.text and password.text and confirm_password.text):
		Global.popup_scene.popup("error", "all fields must be filled")
		return
	if password.text != confirm_password.text:
		Global.popup_scene.popup("error", "password and Confirm Password do not match")
		return
	var data = {
		"email": email.text,
		"username": username.text,
		"password": password.text,
		"password_confirmation": confirm_password.text
	}
	data = str(JSON.print(data))
	Request.send_request(data, Request.signup, {"node": self})
	signup_button.disabled = true

func _on_finished_request_func(data: Dictionary):
	if data["response_code"] == 200 or data["response_code"] == 201:
		if not 'username' in data['body']:
			Request.send_request("", Request.validate, {"node": self, "token": data['body']['token']})
			return
		else:
			Global.save_user_data(data['body'])
			email.text = ''
			username.text = ''
			password.text = ''
			confirm_password.text = ''
			Global.popup_scene.popup('Welcome', "welcome %s. you successfully signed up and signed in." % data['body']['username'])
			Global.main_scene.emit_signal('change_signin_button_text')
			Global.goto_scene()
			Global.clear_back()
	elif data["response_code"] == 400 or data["response_code"] == 404 or data["response_code"] == 401:
		if 'message' in data['body']:
			Global.popup_scene.popup('error', data['body']['message'])
		elif typeof(data['body']) == TYPE_ARRAY and 'message' in data['body'][0]:
			Global.popup_scene.popup('error', data['body'][0]['message'])
		else:
			Global.popup_scene.popup('error', 'Signup was not successful')
	signup_button.disabled = false
