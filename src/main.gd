extends Node2D

@export var default_region: PackedScene

func _ready() -> void:
	if default_region:
		var region_instance = default_region.instantiate()
		add_child(region_instance)
