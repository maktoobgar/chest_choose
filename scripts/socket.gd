extends Node2D

export var SOCKET_URL = "ws://127.0.0.1:3333"
var _client = WebSocketClient.new()


func _ready():
	_client.connect("connection_closed", self, "_on_connection_closed")
	_client.connect("connection_error", self, "_on_connection_closed")
	_client.connect("connection_established", self, "_on_connected")
	_client.connect("data_received", self, "_on_data")
	
	var err = _client.connect_to_url(SOCKET_URL)
	if err != OK:
		print('unable to connect')
		set_process(false)
	
	_send_('channel', 'chat')

func _process(delta):
	_client.poll()

func _on_connection_closed(was_clean = false):
	print('Closed, clean: %s' % was_clean)
	set_process(false)

func _on_connected(proto = ''):
	print('connected with protocol: %s' % proto)

func _on_data():
	var payload = JSON.parse(_client.get_peer(1).get_packet().get_string_from_utf8()).result
	print('received data: %s' % payload)

func _send():
	_client.get_peer(1).put_packet(JSON.print({"test": "Test"}).to_utf8())

func _send_(key: String, value: String):
	_client.get_peer(1).put_packet(JSON.print({key: value}).to_utf8())
