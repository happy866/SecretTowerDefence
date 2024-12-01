extends Node

var coins = 1000
const CELL_SIZE = 16
const COIN_PER_KILL = 15

var dificulty : float = 0.0
var level = 0
var health = 50
var selected_type = 0
var prices : Dictionary = {
	0 : 200,
	1 : 300,
	2 : 400,
	3 : 500
}
var fire_range : Dictionary = {
	0 : 200,
	1 : 300,
	2 : 400,
	3 : 500
}
var fire_velocity : Dictionary = {
	0 : 140,
	1 : 500,
	2 : 400,
	3 : 500
}
var fire_speed : Dictionary = {
	0 : 1.5,
	1 : 0.5,
	2 : 99999,
	3 : 99999
}

func _process(delta: float) -> void:
	if health <= 0:
		print("lost")
		get_tree().quit()
	
	dificulty += 1.0

func next_level():
	level += 1
