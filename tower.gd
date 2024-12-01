extends CharacterBody2D

@onready var TILE_MAP = $"../../TileMap"
const SPEED = 10.0
@export var walking = false
@export var under_control = false
@onready var nav_agent = $NavigationAgent2D
const total_hp = 5.0
var hp : float = total_hp
var self_type = 0
const kule = preload("res://kule voda.tscn")
var canAim = []
var dir


func _ready() -> void:
	nav_agent.target_position = Vector2(150,-100)
	$AnimationPlayer.play("walk_cykle")
	$AnimationPlayer2.play("fire")
	self_type = Global.selected_type
	if self_type == 0:
		$Walk.texture = load("res://animace_kamenna_vez.png")
		$Normal.texture = load("res://veze/kamena.png")
	if self_type == 1:
		$Walk.texture = load("res://animace_vzdusna_vez.png")
		$Normal.texture = load("res://veze/vzdušna vež.png")
	if self_type == 2:
		$Walk.texture = load("res://animace_voda_vez.png")
		$Normal.texture = load("res://veze/vodní vež.png")
		$water.visible = true
	if self_type == 3:
		$Walk.texture = load("res://animace_lava_vez.png")
		$Normal.texture = load("res://veze/lava vez main.png")
		$fire.visible = true

func delete_nav_tile_map():
	var tile_map_cords = TILE_MAP.local_to_map(self.global_position)
	TILE_MAP.set_cell(0, tile_map_cords, 1, Vector2i(1, 0))
	
func _physics_process(delta: float) -> void:
	if walking:
		var direction := to_local(nav_agent.get_next_path_position()).normalized()
		if under_control:
			direction = Vector2.ZERO
		velocity = direction * SPEED
		move_and_slide()

func _process(delta: float) -> void:
	if is_inside_tree() and not walking:
		var clicked_cell_cords = TILE_MAP.local_to_map(self.global_position)
		var atlas_cell_cords = TILE_MAP.get_cell_atlas_coords(0, clicked_cell_cords)
		if atlas_cell_cords == Vector2i(1, 0):
			#delete tower by player
			queue_free()
	
	if (self_type == 3 or self_type == 2) and canAim.size() != 0:
		var ang = self.global_position.angle_to( canAim[0].global_position)
		$fire.rotate(ang) 
		$water.rotate(ang) 
	
	if hp < 1:
		queue_free()
		
	if Input.is_action_just_pressed("stand_up"):
		print("stand up")
		delete_nav_tile_map()
		walking = true
		$Walk.visible = true
		$Normal.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		hp -= 1
		if hp == total_hp:
			$HealthBar.visible = false
		else:
			$HealthBar.visible = true
		if hp <= 0:
			delete_nav_tile_map()
		else:
			$HealthBar.size.x = hp / total_hp * 16.0
		#delete_nav_tile_map()
		body.queue_free()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseMotion:
			if Input.is_action_just_pressed('mouse_click'):
					print('clicked!')


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.


func _on_area_pew_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		canAim.append(body)
	

func _on_area_pew_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		canAim.erase(body)
	


func _on_shoot_timer_timeout() -> void:
	if self_type == 0 or self_type == 1: 
		if canAim.size() != 0:
			var new_kule = kule.instantiate()
			#dir = canAim[0].global_position - self.global_position
			new_kule.global_position = self.global_position
			dir = canAim[0].global_position - self.global_position
			new_kule.velocity = 150 * dir.normalized()
			get_parent().add_child(new_kule)
			


func _on_fire_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.queue_free()
		Global.coins += Global.COIN_PER_KILL
