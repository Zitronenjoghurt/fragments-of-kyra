extends Area2D
class_name Interactable

signal interacted

@export var prompt_y_offset := 0.0
@export var prompt_text := "Interact"

@onready var label: Label = $Label

var _tween: Tween
var _active := false

func _ready() -> void:
	label.text = prompt_text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.hide()
	
	await get_tree().process_frame
	label.pivot_offset = label.size / 2.0
	label.position = Vector2(-label.size.x / 2.0, prompt_y_offset)
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _unhandled_input(event: InputEvent) -> void:
	if _active and event.is_action_pressed("Interact"):
		get_viewport().set_input_as_handled()
		_do_interact()

func _do_interact() -> void:
	interacted.emit()
	_active = false
	_hide_prompt()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_active = true
		_show_prompt()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_active = false
		_hide_prompt()

func _show_prompt() -> void:
	if _tween:
		_tween.kill()
	
	label.show()
	label.scale = Vector2.ZERO
	label.modulate.a = 0.0
	
	_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	_tween.tween_property(label, "scale", Vector2.ONE * 0.25, 0.15)
	_tween.parallel().tween_property(label, "modulate:a", 1.0, 0.1)

func _hide_prompt() -> void:
	if _tween:
		_tween.kill()
	
	_tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUINT)
	_tween.tween_property(label, "scale", Vector2.ZERO, 0.1)
	_tween.parallel().tween_property(label, "modulate:a", 0.0, 0.1)
	_tween.tween_callback(label.hide)
