extends CharacterBody2D


const SPEED = 30.0
@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	nav_agent.target_position = Vector2.ZERO
	$AnimationPlayer.play("enemy_walk")

func _physics_process(delta: float) -> void:

	var direction := to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * SPEED
	
	move_and_slide()
	
	if global_position.distance_to(Vector2.ZERO) < 10:
		Global.health -= 1
		queue_free()
