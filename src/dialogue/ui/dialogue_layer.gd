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

@onready var arrow: Sprite2D = %Arrow
var _arrow_tween: Tween
var _arrow_base_y: float

var _current_dialogue: Dialogue
var _dialogue_index: int

func start(dialogue: Dialogue):
	_arrow_base_y = arrow.position.y
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
	
	if _dialogue_index < _current_dialogue.entries.size() - 1:
		_start_arrow()
	else:
		_stop_arrow()
	

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

func _start_arrow():
	_stop_arrow()
	
	var base_y = arrow.position.y
	_arrow_tween = create_tween().set_loops()
	_arrow_tween.tween_property(arrow, "position:y", base_y + 6, 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	_arrow_tween.tween_property(arrow, "position:y", base_y, 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	arrow.show()

func _stop_arrow():
	arrow.hide()
	if _arrow_tween:
		_arrow_tween.kill()
		_arrow_tween = null
	arrow.position.y = _arrow_base_y

func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	
	if event.is_action_pressed("Interact"):
		_advance_dialogue()

func _advance_dialogue() -> void:
	_dialogue_index += 1
	
	if _dialogue_index >= _current_dialogue.entries.size():
		_end_dialogue()
	else:
		_show_current_entry()

func _end_dialogue():
	_stop_arrow()
	hide()
	_current_dialogue = null
	_dialogue_index = 0
