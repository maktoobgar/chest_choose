extends Node2D


const Chest: Resource = preload("res://scenes/instances/chest.tscn")

func _ready():
	Global._ready()
	Global.select_character_func()
	replace_chest_pivots()

func replace_chest_pivots():
	for chest_place in Global.chests.get_children():
		var chest: Area2D = Chest.instance()
		chest.position = chest_place.position
		chest_place.replace_by(chest, false)
