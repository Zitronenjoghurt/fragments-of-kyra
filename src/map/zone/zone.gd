extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		var shape = $CollisionShape2D.shape as RectangleShape2D
		var scaled_size = shape.size * scale
		var rect = Rect2(global_position - scaled_size / 2, scaled_size)
		CameraManager.set_zone(rect)
