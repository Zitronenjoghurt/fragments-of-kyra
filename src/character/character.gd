extends CharacterBody2D
class_name Character

@export var sprite_kind: CharacterSprite.CharacterSpriteKind
@export var speed := 80.0
@export var bob_amount := 0.05
@export var bob_duration := 0.4
@onready var sprite: CharacterSprite = $CharacterSprite

var movement_direction := Vector2.ZERO
var _last_direction := "down"
var _bob_tween: Tween

func _ready() -> void:
	sprite.set_sprite_kind(sprite_kind)
	_start_bob()

func _physics_process(_delta: float) -> void:
	velocity = movement_direction * speed
	move_and_slide()
	_update_animation()

func _update_animation():
	if movement_direction == Vector2.ZERO:
		sprite.play("idle_" + _get_direction_name())
	else:
		sprite.play("walk_" + _get_direction_name())

func _get_direction_name() -> String:
	if movement_direction == Vector2.ZERO:
		return _last_direction
	
	if abs(movement_direction.x) > abs(movement_direction.y):
		_last_direction = "right" if movement_direction.x > 0 else "left"
	else:
		_last_direction = "down" if movement_direction.y > 0 else "up"
	
	return _last_direction

func _start_bob() -> void:
	var height = sprite.sprite_frames.get_frame_texture("idle_down", 0).get_height()
	var offset = height * bob_amount * 0.5
	
	_bob_tween = create_tween().set_loops()
	_bob_tween.tween_property(sprite, "scale:y", 1.0 - bob_amount, bob_duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	_bob_tween.parallel().tween_property(sprite, "position:y", offset, bob_duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	_bob_tween.tween_property(sprite, "scale:y", 1.0, bob_duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	_bob_tween.parallel().tween_property(sprite, "position:y", 0.0, bob_duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
