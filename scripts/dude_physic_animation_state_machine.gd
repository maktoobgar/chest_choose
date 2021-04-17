extends KinematicBody2D

const SPEED: int = 20
const SPEEDPLUS: int = 30
const GRAVITY: int = 200
const JUMP: int = -350
const NOT_ON_FLOOR_LIMIT: int = 10

enum {Idle, Walk, Run ,Attack, Walk_Attack, Jump, Fall, Climb, Hurt, Die}

var character_state = Idle
var speed: float = 0
var gravity: float = 0
var not_on_floor_ignore_times: int = 0
var velocity: Vector2 = Vector2.ZERO
onready var animation_state_machine: AnimationNodeStateMachinePlayback = get_node('./animationStateMachine').get('parameters/playback')
onready var animation_tree: AnimationTree = get_node('./animationStateMachine')
onready var character: Sprite = get_node('./character')

func _ready():
	animation_state_machine.start('Idle')
	animation_tree.active = true

func _physics_process(delta):
	move()

func _process(delta):
	change_animation_state_machine()
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
	if is_on_floor():
		if Input.is_action_just_pressed('ui_jump'):
			gravity = 1
			if randi() % 2 and animation_state_machine.get_current_node() != 'Jump':
				gravity = JUMP
		else:
			gravity = 1
	else:
		gravity = lerp(gravity, GRAVITY, 0.05)
	velocity = move_and_slide(Vector2(speed, gravity), Vector2(0, -1), true, 4)

func change_animation_state_machine() -> void:
	match character_state:
		Idle:
			if not custom_is_on_floor() and velocity.y > 0:
				animation_state_machine.travel('Fall')
				character_state = Fall
			elif Input.is_action_just_pressed('ui_jump'):
				animation_state_machine.travel('Jump')
				character_state = Jump
			elif Input.is_action_pressed("ui_right"):
				if Input.is_action_pressed('ui_shift'):
					animation_state_machine.travel('Run')
					character_state = Run
					return
				animation_state_machine.travel('Walk')
				character_state = Walk
			elif Input.is_action_pressed("ui_left"):
				if Input.is_action_pressed("ui_shift"):
					animation_state_machine.travel('Run')
					character_state = Run
					return
				animation_state_machine.travel('Walk')
				character_state = Walk
			elif Input.is_action_just_pressed('ui_attack'):
				animation_state_machine.travel('Attack')
				character_state = Attack
		Walk:
			if not custom_is_on_floor() and velocity.y > 0:
				animation_state_machine.travel('Fall')
				character_state = Fall
			elif Input.is_action_just_pressed('ui_jump'):
				animation_state_machine.travel('Jump')
				character_state = Jump
			elif Input.is_action_pressed("ui_right"):
				if Input.is_action_pressed('ui_shift'):
					animation_state_machine.travel('Run')
					character_state = Run
			elif Input.is_action_pressed("ui_left"):
				if Input.is_action_pressed("ui_shift"):
					animation_state_machine.travel('Run')
					character_state = Run
			else:
				animation_state_machine.travel('Idle')
				character_state = Idle
		Run:
			if not custom_is_on_floor() and velocity.y > 0:
				animation_state_machine.travel('Fall')
				character_state = Fall
			elif Input.is_action_just_pressed('ui_jump'):
				animation_state_machine.travel('Jump')
				character_state = Jump
			elif Input.is_action_pressed("ui_right"):
				if Input.is_action_pressed('ui_shift'):
					return
				animation_state_machine.travel('Walk')
				character_state = Walk
			elif Input.is_action_pressed("ui_left"):
				if Input.is_action_pressed("ui_shift"):
					return
				animation_state_machine.travel('Walk')
				character_state = Walk
			else:
				animation_state_machine.travel('Idle')
				character_state = Idle
		Attack:
			if not custom_is_on_floor() and velocity.y > 0:
				animation_state_machine.travel('Fall')
				character_state = Fall
			elif Input.is_action_just_pressed('ui_jump'):
				animation_state_machine.travel('Jump')
				character_state = Jump
			else:
				character_state = Idle
		Jump:
			if not custom_is_on_floor() and velocity.y > 0:
				animation_state_machine.travel('Fall')
				character_state = Fall
			else:
				character_state = Idle
		Fall:
			if custom_is_on_floor():
				animation_state_machine.travel('Idle')
				character_state = Idle

func align_face() -> void:
	if Input.is_action_pressed("ui_right_shift") or Input.is_action_pressed("ui_right"):
		if character.scale.x != 1:
			character.scale.x = 1
	elif Input.is_action_pressed("ui_left_shift") or Input.is_action_pressed("ui_left"):
		if character.scale.x != -1:
			character.scale.x = -1

func custom_is_on_floor():
	if not is_on_floor():
		not_on_floor_ignore_times += 1
		if not_on_floor_ignore_times > NOT_ON_FLOOR_LIMIT:
			not_on_floor_ignore_times = NOT_ON_FLOOR_LIMIT + 1
			return false
		return true
	not_on_floor_ignore_times = 0
	return true
