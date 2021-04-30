extends Area2D


signal select_and_set_color

onready var chestAnimation = get_node('./chestAnimation')
var collided: bool = false
var box_state = Global.BoxStates.NOTOPENED

export(String) var title
export(String) var context

func _ready():
	self.connect('select_and_set_color', self, 'select_and_set_color_func')

func _process(delta):
	if Input.is_action_just_released("ui_interact") and collided and box_state == Global.BoxStates.NOTOPENED and Global.player.has_box_func():
		box_state = Global.BoxStates.OPENED
		chestAnimation.play("Open")
		Global.scroll.emit_signal('play', ['Title', 'text'])
		Global.player.emit_signal("stop_move")
		Global.hint.emit_signal('visible', false)
	elif Input.is_action_just_released("ui_lock") and collided and box_state == Global.BoxStates.NOTOPENED:
		Global.player.emit_signal('set_box', self)
	elif Input.is_action_just_released("ui_lock") and collided and box_state == Global.BoxStates.LOCKED:
		Global.player.emit_signal('clean_box')

func _on_chest_body_entered(body):
	if box_state != Global.BoxStates.OPENED:
		collided = true
		Global.hint.emit_signal('change_text', next_text())
		Global.hint.emit_signal('visible', true)

func _on_chest_body_exited(body):
	if box_state != Global.BoxStates.OPENED:
		collided = false
		Global.hint.emit_signal('visible', false)

func select_and_set_color_func():
	if self.modulate == Color.white:
		self.modulate = Color.cyan
		box_state = Global.BoxStates.LOCKED
		Global.hint.emit_signal('change_text', next_text())
	elif self.modulate == Color.cyan:
		self.modulate = Color.white
		box_state = Global.BoxStates.NOTOPENED
		Global.hint.emit_signal('change_text', next_text())

func next_text() -> String:
	if box_state == Global.BoxStates.NOTOPENED and collided:
		return 'Press F To Open-E To Lock'
	elif box_state == Global.BoxStates.LOCKED and collided:
		return 'Press E To Clean Your Choice'
	else:
		return ''
