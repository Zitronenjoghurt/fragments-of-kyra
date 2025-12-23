extends CanvasLayer

@onready var simple_box: TextureRect = %SimpleBox
@onready var simple_text: RichTextLabel = %SimpleText

@onready var name_box: TextureRect = %NameBox
@onready var name_name: Label = %NameName
@onready var name_text: RichTextLabel = %NameText

@onready var face_box: TextureRect = %FaceBox
@onready var face_name: Label = %FaceName
@onready var face_text: RichTextLabel = %FaceText
@onready var face_texture: TextureRect = %FaceTexture

var _current_dialogue: Dialogue
var _dialogue_index: int

func start(dialogue: Dialogue):
	_current_dialogue = dialogue
	_dialogue_index = 0
	show()
	_show_current_entry()

func _show_current_entry():
	var entry = _current_dialogue.entries[_dialogue_index]
	
	simple_box.hide()
	name_box.hide()
	face_box.hide()
	
	if not entry.name.is_empty() and entry.face_set != Dialogue.FaceSet.NONE:
		_show_face(entry)
	elif not entry.name.is_empty():
		_show_name(entry)
	else:
		_show_simple(entry)
	

func _show_simple(entry: DialogueEntry):
	simple_box.show()
	simple_text.text = entry.text

func _show_name(entry: DialogueEntry):
	name_box.show()
	name_text.text = entry.text
	name_name.text = entry.name

func _show_face(entry: DialogueEntry):
	face_box.show()
	face_text.text = entry.text
	face_name.text = entry.name
	if entry.face_set:
		face_texture.texture = Dialogue.FACESET_TEXTURES[entry.face_set]
