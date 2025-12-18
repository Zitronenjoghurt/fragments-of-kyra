extends Node
class_name PlayerController

func _physics_process(_delta: float) -> void:
	var character = get_parent() as Character
	character.movement_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
