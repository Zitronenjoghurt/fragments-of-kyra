extends CharacterBody2D
class_name Character

@export var sprite_kind: CharacterSprite.CharacterSpriteKind
@export var speed := 80.0
@onready var sprite: CharacterSprite = $CharacterSprite

var movement_direction := Vector2.ZERO
var _last_direction := "down"

func _ready() -> void:
	sprite.set_sprite_kind(sprite_kind)

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
