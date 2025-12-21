extends Area2D
class_name Zone

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		CameraManager.enter_zone(self)

func _on_body_exited(body: Node2D):
	if body.is_in_group("player"):
		CameraManager.exit_zone(self)

func get_rect() -> Rect2:
	var shape = $CollisionShape2D.shape as RectangleShape2D
	var scaled_size = shape.size * scale
	return Rect2(global_position - scaled_size / 2, scaled_size)
