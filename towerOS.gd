extends CharacterBody2D

@onready var TILE_MAP = $"../../TileMap"
const SPEED = 100.0
@export var walking = false
@export var under_control = false
@onready var nav_agent = $NavigationAgent2D
var hp = 3
const kule = preload("res://kule voda.tscn")
var canAim = []
var dir


func _ready() -> void:
	nav_agent.target_position = Vector2.ZERO
	$AnimationPlayer.play()

func delete_nav_tile_map():
	var tile_map_cords = TILE_MAP.local_to_map(self.global_position)
	TILE_MAP.set_cell(0, tile_map_cords, 0, Vector2i(1, 0))
	
func _physics_process(delta: float) -> void:
	if walking:
		var direction := to_local(nav_agent.get_next_path_position()).normalized()
		if under_control:
			direction = Vector2.ZERO
		velocity = direction * SPEED
		move_and_slide()

func _process(delta: float) -> void:
	#if is_inside_tree() and not walking:
		#var clicked_cell_cords = TILE_MAP.local_to_map(self.global_position)
		#var atlas_cell_cords = TILE_MAP.get_cell_atlas_coords(0, clicked_cell_cords)
		#if atlas_cell_cords == Vector2i(1, 0):
			##delete tower by player
			#queue_free()
		
	if hp < 1:
		queue_free()
		
	
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	#if "enemy" in body.name:
	if body.is_in_group("enemies"):
		print("emntred")
		hp -= 1
		delete_nav_tile_map()
		body.queue_free()
	
	if Input.is_action_just_pressed("stand_up"):
		delete_nav_tile_map()
		walking = true



	


func _on_area_pew_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("enemies"):
		canAim.append(body)
	

func _on_area_pew_body_exited(body: Node2D) -> void:
	
	if body.is_in_group("enemies"):
		canAim.erase(body)
	


func _on_shoot_timer_timeout() -> void:
	if true: 
		
		var new_kule = kule.instantiate()
		self.add_child(new_kule)
		if canAim.size() > 0:
			print("shot")
			#dir = canAim[0].global_position - self.global_position
			var ang = self.global_position.angle_to(canAim[0].global_position)
			dir = Vector2.ONE.rotated(ang)
			new_kule.global_position = self.global_position
			new_kule.vlll = 10 * dir.normalize()
			
