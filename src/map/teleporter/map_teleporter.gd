extends Area2D
class_name MapTeleporter

@export var destination: Marker2D

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		CameraManager.next_snap_instant()
		body.global_position = destination.global_position
