extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("tower"):
		body.queue_free()
		if $Sprite2D.frame == 5:
			print("next level")
			Global.next_level()
		$Sprite2D.frame += 1
		
