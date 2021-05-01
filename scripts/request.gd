extends HTTPRequest


const host: String = "http://localhost:3333/"
const signup: String = "signup/"
const signin: String = "signin/"
const me: String = "me/"
const validate: String = "validate/%s"
const headers: PoolStringArray = PoolStringArray(
	["Content-Type: application/json", "User-Agent: open-boxes-game", "charset:utf-8", "Connection: keep-alive", "Keep-Alive: timeout=10"])

var node: Node = null

func _ready():
	self.timeout = 10
	self.connect("request_completed", self, "_on_request_completed")

func _on_request_completed(result, response_code, headers, body):
	if node:
		body = JSON.parse(body.get_string_from_utf8()).result
		if body == null:
			body = {}
		var tempnode = node
		node = null
		tempnode.emit_signal("_on_finished_request", {"response_code": response_code, "body": body})

func _debug(body):
	var file = File.new()
	file.open("res://error.html", File.WRITE)
	file.store_string(body.get_string_from_utf8())
	file.close()

func send_request(data = null, url: String = "", extra: Dictionary = {}) -> void:
	if not node:
		if 'node' in extra:
			node = extra['node']
		if url == self.signin or url == self.signup:
			request(host+url, headers, true, HTTPClient.METHOD_POST, data)
		elif url == self.me:
			request(host+url, headers, false, HTTPClient.METHOD_GET, data)
		elif url == self.validate:
			print('validate')
			request((host+url) % extra['token'], headers, false, HTTPClient.METHOD_GET, data)
