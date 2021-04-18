extends Control


onready var root = get_tree().root.get_child(0)
onready var mouse: Node2D = root.find_node('mouse')
onready var dialog: HBoxContainer = root.find_node('dialog')
onready var player: KinematicBody2D = root.find_node('player')

func _ready():
	self.visible = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if not self.visible:
			self.visible = true
			mouse.visible = true
			player.emit_signal("stop_move")
		else:
			self.visible = false
			mouse.visible = false
			player.emit_signal("allow_move")
