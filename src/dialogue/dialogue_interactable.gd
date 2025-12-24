extends Node2D
class_name DialogueInteractable

@export var dialogue: Dialogue
@export var interactable: Interactable

func _ready() -> void:
	interactable.interacted.connect(_on_interacted)

func _on_interacted() -> void:
	DialoguePlayer.start(dialogue)
