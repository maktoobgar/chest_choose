extends Control


onready var root = get_tree().root.get_child(0)

func _ready():
	self.visible = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if not self.visible:
			self.visible = true
			Global.mouse.visible = true
			Global.player.emit_signal("stop_move")
		else:
			self.visible = false
			Global.mouse.visible = false
			Global.player.emit_signal("allow_move")
