extends StaticBody2D

const  INIT_HEALT = 20
var health  = INIT_HEALT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("tower"):
		body.queue_free()
		
		if health < 1:
			print("next level")
			Global.next_level()
		health -= 1
		$Sprite2D.frame = floor(remap(health, 19, 1, 1, 5))
		print(health)
		print($Sprite2D.frame)
		
