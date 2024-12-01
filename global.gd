extends Node

var coins = 800
const CELL_SIZE = 16
const COIN_PER_KILL = 15

var dificulty : float = 0.0
var level = 1
var health = 50
var selected_type = 0
var prices : Dictionary = {
	0 : 200,
	1 : 1000,
	2 : 1000,
	3 : 1500
}
var fire_range : Dictionary = { #not implemented
	0 : 200,
	1 : 300,
	2 : 400,
	3 : 500
}
var fire_velocity : Dictionary = { #not implemented
	0 : 140,
	1 : 500,
	2 : 400,
	3 : 500
}
var fire_speed : Dictionary = {
	0 : 1.5,
	1 : 0.5,
	2 : 2,
	3 : 3
}

func _process(delta: float) -> void:
	if health <= 0:
		print("lost")
		get_tree().quit()
	
	dificulty += 1.0

func next_level():
	level += 1
	get_tree().change_scene_to_file("res://Main.tscn")
