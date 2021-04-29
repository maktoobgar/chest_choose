extends Node


enum BoxState {NOTOPENED, OPENED, LOCKED}

onready var root: Node = get_tree().root.get_child(1)
onready var player: KinematicBody2D = root.get_node_or_null('player')
onready var chests: Node2D = root.get_node_or_null('chests')
onready var hint: HBoxContainer = root.get_node_or_null('cameraCanvas/hint')
onready var scroll: Control = root.get_node_or_null('cameraCanvas/scroll')
onready var ui: Control = root.get_node_or_null('cameraCanvas/ui')
onready var mouse: Node2D = root.get_node_or_null('cameraCanvas/mouse')
