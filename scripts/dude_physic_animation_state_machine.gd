extends KinematicBody2D

const SPEED: int = 30
const SPEEDPLUS: int = 50

enum {Idle, Walk, Run ,Attack, Walk_Attack, Jump, Climb, Hurt, Die}

var character_state = Idle
var speed: float = 0
onready var state_machine: AnimationNodeStateMachinePlayback = get_node('./animationStateMachine').get('parameters/playback')
onready var animation_tree: AnimationTree = get_node('./animationStateMachine')
onready var character: Sprite = get_node('./character')

func _ready():
	state_machine.start('Idle')
	animation_tree.active = true

func _physics_process(delta):
	move()

func _process(delta):
	state_machine()
	align_face()

func move() -> void:
	var till: float = 0
	if Input.is_action_pressed("ui_right"):
		till = SPEED
		if Input.is_action_pressed('ui_shift'):
			till = SPEEDPLUS
	elif Input.is_action_pressed("ui_left"):
		till = -SPEED
		if Input.is_action_pressed('ui_shift'):
			till = -SPEEDPLUS
	speed = lerp(speed, till, 0.1)
	move_and_slide(Vector2(speed, 0), Vector2(0, -1))

func state_machine() -> void:
	match character_state:
		Idle:
			if Input.is_action_pressed("ui_right"):
				if Input.is_action_pressed('ui_shift'):
					state_machine.travel('Run')
					character_state = Run
					return
				state_machine.travel('Walk')
				character_state = Walk
			elif Input.is_action_pressed("ui_left"):
				if Input.is_action_pressed("ui_shift"):
					state_machine.travel('Run')
					character_state = Run
					return
				state_machine.travel('Walk')
				character_state = Walk
			elif Input.is_action_just_pressed('ui_attack'):
				state_machine.travel('Attack')
				character_state = Attack
			elif Input.is_action_just_pressed('ui_jump'):
				state_machine.travel('Jump')
				character_state = Jump
		Walk:
			if Input.is_action_pressed("ui_right"):
				if Input.is_action_pressed('ui_shift'):
					state_machine.travel('Run')
					character_state = Run
			elif Input.is_action_pressed("ui_left"):
				if Input.is_action_pressed("ui_shift"):
					state_machine.travel('Run')
					character_state = Run
			else:
				state_machine.travel('Idle')
				character_state = Idle
		Run:
			if Input.is_action_pressed("ui_right"):
				if Input.is_action_pressed('ui_shift'):
					return
				state_machine.travel('Walk')
				character_state = Walk
			elif Input.is_action_pressed("ui_left"):
				if Input.is_action_pressed("ui_shift"):
					return
				state_machine.travel('Walk')
				character_state = Walk
			else:
				state_machine.travel('Idle')
				character_state = Idle
		Attack:
			character_state = Idle
		Jump:
			character_state = Idle

func align_face() -> void:
	if Input.is_action_pressed("ui_right_shift") or Input.is_action_pressed("ui_right"):
		if character.scale.x != 1:
			character.scale.x = 1
	elif Input.is_action_pressed("ui_left_shift") or Input.is_action_pressed("ui_left"):
		if character.scale.x != -1:
			character.scale.x = -1
