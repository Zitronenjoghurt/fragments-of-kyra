extends Node2D
class_name Region

@export var default_player_spawn: Marker2D

func _ready() -> void:
	CameraManager.next_snap_instant()
	_spawn_player()

func _spawn_player() -> void:
	var player = Scenes.CHARACTER_SCENE.instantiate()
	player.sprite_kind = CharacterSprite.CharacterSpriteKind.SPIRIT
	if default_player_spawn:
		player.global_position = default_player_spawn.global_position
	add_child(player)
	player.add_to_group("player")
	
	var controller = PlayerController.new()
	player.add_child(controller)
