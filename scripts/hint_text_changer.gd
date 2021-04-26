extends HBoxContainer


signal change_text
signal visible

onready var label = find_node('label')
onready var animation: AnimationPlayer = get_node('./animation')

func _ready() -> void:
	self.connect("change_text", self, 'change_text_func')
	self.connect("visible", self, 'visible_func')
	self.visible = false
	animation.play("Fade")
	label.text = ""

func change_text_func(text: String) -> void:
	self.visible = true
	if text:
		label.text = text.replace('\\n', '\n')
	else:
		label.text = ""

func visible_func(on_off: bool = true) -> void:
	self.visible = true
	if on_off:
		animation.play_backwards("Fade")
	else:
		animation.play("Fade")
