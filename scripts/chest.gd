extends Area2D


signal select_and_set_color

onready var root = get_tree().root.get_child(0)
onready var chestAnimation = get_node_or_null('./chestAnimation')
onready var player = root.find_node('player')
onready var dialog: HBoxContainer = root.find_node('dialog')
var collided: bool = false
var opened: bool = false
var openable: bool = true

func _ready():
	self.connect('select_and_set_color', self, 'select_and_set_color_func')

func _process(delta):
	if Input.is_action_just_released("ui_interact"):
		if collided and not opened and openable:
			opened = true
			chestAnimation.play("Open")
			dialog.visible = false
	elif Input.is_action_just_released("ui_lock") and openable:
		if collided and not opened:
			player.emit_signal('set_box', self)
	elif Input.is_action_just_released("ui_lock") and not openable:
		if collided and not opened:
			player.emit_signal('clean_box')

func _on_chest_body_entered(body):
	if not opened:
		collided = true
		dialog.emit_signal('change_text', next_text())
		dialog.visible = true

func _on_chest_body_exited(body):
	if not opened:
		collided = false
		dialog.visible = false

func select_and_set_color_func():
	if self.modulate == Color.white:
		self.modulate = Color.cyan
		openable = false
		dialog.emit_signal('change_text', next_text())
	elif self.modulate == Color.cyan:
		self.modulate = Color.white
		openable = true
		dialog.emit_signal('change_text', next_text())

func next_text() -> String:
	if openable and not opened:
		return 'Press F To Open-E To Lock'
	else:
		return 'Press E To Clean Your Choice'
