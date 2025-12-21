extends Node

const tween_duration := 0.5

var camera: Camera2D
var target_position: Vector2
var target_zoom: Vector2

var active_zones: Array[Zone] = []
var snap_instant_frame := -999

func _ready():
	camera = Camera2D.new()
	add_child(camera)
	camera.make_current()

func next_snap_instant() -> void:
	snap_instant_frame = Engine.get_physics_frames()

func enter_zone(zone: Zone):
	active_zones.append(zone)
	set_zone(zone.get_rect())

func exit_zone(zone: Zone):
	active_zones.erase(zone)
	if active_zones.size() > 0:
		set_zone(active_zones[-1].get_rect())

func set_zone(rect: Rect2):
	target_position = rect.get_center()
	
	var viewport_size = get_viewport().get_visible_rect().size
	var zoom_x = viewport_size.x / rect.size.x
	var zoom_y = viewport_size.y / rect.size.y
	var zoom_level = min(zoom_x, zoom_y)
	target_zoom = Vector2(zoom_level, zoom_level)
	
	if Engine.get_physics_frames() - snap_instant_frame <= 2:
		camera.global_position = target_position
		camera.zoom = target_zoom
	else:
		var tween = create_tween().set_parallel(true)
		tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(camera, "global_position", target_position, tween_duration)
		tween.tween_property(camera, "zoom", target_zoom, tween_duration)
