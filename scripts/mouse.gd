extends Node2D

var click = load('res://mouse/click.png')
var idle = load('res://mouse/idle.png')
onready var mouseSprite: Sprite = get_node_or_null('./mouseSprite')


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.visible = false

func _process(delta):
	self.position = get_global_mouse_position()
	if Input.is_action_pressed("ui_attack"):
		if mouseSprite.texture != click:
			mouseSprite.texture = click
	else:
		if mouseSprite.texture != idle:
			mouseSprite.texture = idle
