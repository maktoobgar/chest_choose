extends Area2D


onready var root = get_tree().root.get_child(0)
onready var chestAnimation = get_node_or_null('./chestAnimation')
onready var dialog: HBoxContainer = root.find_node('dialog')
var player: KinematicBody2D = null
var opened: bool = false

func _ready():
	dialog.visible = false

func _process(delta):
	if Input.is_action_just_released("ui_interact"):
		if player:
			if not opened:
				opened = true
				chestAnimation.play("Open")
				dialog.visible = false
				player = null

func _on_chest_body_entered(body):
	if not opened:
		player = body
		dialog.visible = true

func _on_chest_body_exited(body):
	if not opened:
		player = null
		dialog.visible = false
