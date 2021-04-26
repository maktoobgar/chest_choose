extends Control


signal play
signal play_backward

onready var margin: MarginContainer = get_node('./scrollPicMargin')
onready var animation: AnimationPlayer = get_node('./animation')
onready var title: Label = find_node('title')
onready var context: Label = find_node('context')
var backward: bool = false

func _ready():
	self.visible = false
	self.connect("play", self, "play_func")

func _process(delta):
	margin.rect_pivot_offset = margin.rect_size/2
	if Input.is_action_just_pressed("ui_attack") and backward:
		play_backward_func()
		backward = false

func play_func(attr: Array) -> void:
	title.text = attr[0].replace('\\n', '\n')
	context.text = attr[1].replace('\\n', '\n')
	margin.rect_scale = Vector2(0, 0)
	animation.play("scroll_open")
	self.visible = true
	backward = true

func play_backward_func() -> void:
	animation.play_backwards("scroll_open")
	Global.player.emit_signal('allow_move')
