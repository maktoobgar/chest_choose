extends HBoxContainer


signal change_text

onready var label = find_node('label')

func _ready():
	self.visible = false
	self.connect("change_text", self, 'change_text_func')

func change_text_func(text: String):
	label.text = text.replace('\\n', '\n')
