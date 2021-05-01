extends Control


onready var accept_dialog: AcceptDialog = find_node('dialog')
onready var label: Label = find_node('label')

func popup(title, text):
	label.text = text
	accept_dialog.window_title = title
	accept_dialog.popup_centered()
