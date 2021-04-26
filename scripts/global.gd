extends Node


enum BoxState {NOTOPENED, OPENED, LOCKED}

onready var root: Node2D = get_tree().root.get_child(1)
onready var player: KinematicBody2D = root.find_node('player')
onready var chests: Node2D = root.find_node('chests')
onready var hint: HBoxContainer = root.find_node('hint')
onready var scroll: Control = root.find_node('scroll')
onready var ui: Control = root.find_node('ui')
onready var mouse: Node2D = root.find_node('mouse')
