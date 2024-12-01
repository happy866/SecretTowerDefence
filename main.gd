extends Node2D

@onready var ENEMY = preload("res://enemy.tscn")
@onready var TOWER = preload("res://tower.tscn")
@onready var TILE_MAP = $TileMap
var selected : CharacterBody2D = null

func _ready() -> void:
	pass 
	
func select_me(me):
	selected = me

func _process(delta: float) -> void:
	if Input.is_action_pressed("left_click"):
		get_clicked_tile()
	if Input.is_action_pressed("right_click"):
		clear_tile()
	
	$Timer.wait_time = float($Dificulty.time_left / 120) + 0.2
	
	$Control/HP.text = str(Global.health)
	$Control/COINS.text = str(Global.coins)
	$Control/Level.text = "lvl: " + str(Global.level)

func get_clicked_tile():
	var clicked_cell_cords = TILE_MAP.local_to_map(TILE_MAP.get_local_mouse_position())
	var atlas_cell_cords = TILE_MAP.get_cell_atlas_coords(0, clicked_cell_cords)
	if atlas_cell_cords != Vector2i(0, 0):
		if Global.prices[Global.selected_type] > Global.coins:
			return
		Global.coins -= Global.prices[Global.selected_type]
		TILE_MAP.set_cell(0, clicked_cell_cords, 1, Vector2i(0, 0))
		
		var new_tower = TOWER.instantiate()
		new_tower.global_position = (clicked_cell_cords * Global.CELL_SIZE) + Vector2i(Global.CELL_SIZE/2, Global.CELL_SIZE/2)
		$towers.add_child(new_tower)


func clear_tile():
	var clicked_cell_cords = TILE_MAP.local_to_map(TILE_MAP.get_local_mouse_position())
	TILE_MAP.set_cell(0, clicked_cell_cords, 1, Vector2i(1, 0))

func _on_timer_timeout() -> void:
	var new_enemy = ENEMY.instantiate()
	new_enemy.global_position = Vector2(randi_range(-200,200), randi_range(-200,200))
	while new_enemy.global_position.distance_to(Vector2.ZERO) <= 50:
		new_enemy.global_position = Vector2(randi_range(-200,200), randi_range(-200,200))
	add_child(new_enemy)


func _on_stone_toggled(toggled_on: bool) -> void:
	$Control/Lava/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Water/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Wind/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Stone/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Stone/Sprite2D.modulate = Color(Color.WHITE, 1.0)
	Global.selected_type = 0


func _on_wind_toggled(toggled_on: bool) -> void:
	$Control/Lava/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Water/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Wind/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Stone/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Wind/Sprite2D.modulate = Color(Color.WHITE, 1.0)
	Global.selected_type = 1


func _on_water_toggled(toggled_on: bool) -> void:
	$Control/Lava/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Water/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Wind/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Stone/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Water/Sprite2D.modulate = Color(Color.WHITE, 1.0)
	Global.selected_type = 2


func _on_lava_toggled(toggled_on: bool) -> void:
	$Control/Lava/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Water/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Wind/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Stone/Sprite2D.modulate = Color(Color.WHITE, 0.5)
	$Control/Lava/Sprite2D.modulate = Color(Color.WHITE, 1.0)
	Global.selected_type = 3
