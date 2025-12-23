extends AnimatedSprite2D
class_name CharacterSprite

enum CharacterSpriteKind {
	BOY,
	GREEN_NINJA, 
	SPIRIT
}

const SPRITESHEETS = {
	CharacterSpriteKind.BOY: preload("res://assets/characters/boy/sprite_sheet.png"),
	CharacterSpriteKind.GREEN_NINJA: preload("res://assets/characters/ninja_green/sprite_sheet.png"),
	CharacterSpriteKind.SPIRIT: preload("res://assets/characters/spirit/sprite_sheet.png"),
}

func set_sprite_kind(kind: CharacterSpriteKind) -> void:
	sprite_frames = sprite_frames.duplicate(true)
	var spritesheet = SPRITESHEETS[kind]
	for anim_name in sprite_frames.get_animation_names():
		for i in sprite_frames.get_frame_count(anim_name):
			var atlas: AtlasTexture = sprite_frames.get_frame_texture(anim_name, i)
			atlas.atlas = spritesheet
