extends CenterContainer

onready var label: Label = find_node('label')
export(String) var text: String


func _ready():
	text = text.replace('\\n', '\n')
	label.text = text
