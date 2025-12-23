extends Resource
class_name Dialogue

enum FaceSet {
	NONE,
	BOY,
	GREEN_NINJA,
	SPIRIT,
}

const FACESET_TEXTURES = {
	FaceSet.BOY: preload("res://assets/characters/boy/faceset.png"),
	FaceSet.GREEN_NINJA: preload("res://assets/characters/ninja_green/faceset.png"),
	FaceSet.SPIRIT: preload("res://assets/characters/spirit/faceset.png"),
}

@export var entries: Array[DialogueEntry]
