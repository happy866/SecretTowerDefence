extends CharacterBody2D


const SPEED = 10
var vlll = Vector2.ZERO

func _physics_process(delta: float) -> void:
	move_and_slide()
	


func _on_kill_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.queue_free()
		Global.coins += Global.COIN_PER_KILL
