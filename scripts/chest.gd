extends Area2D

var player: KinematicBody2D = null
var opened: bool = false
onready var chestAnimation = get_node_or_null('./chestAnimation')

func _process(delta):
	if Input.is_action_just_released("ui_interact"):
		if player:
			if not opened:
				opened = true
				chestAnimation.play("Open")
				player.get_node_or_null('./cameraCanvas/dialog').visible = false
				player = null

func _on_chest_body_entered(body):
	if not opened:
		var dialog = body.get_node_or_null('./cameraCanvas/dialog')
		player = body
		dialog.visible = true


func _on_chest_body_exited(body):
	if not opened:
		var dialog = body.get_node_or_null('./cameraCanvas/dialog')
		player = null
		dialog.visible = false
