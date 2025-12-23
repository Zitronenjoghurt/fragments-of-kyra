extends CanvasLayer

@onready var simple_box: NinePatchRect = %SimpleBox
@onready var simple_text: RichTextLabel = %SimpleText

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
	
	_show_simple(entry)

func _show_simple(entry: DialogueEntry):
	simple_box.show()
	simple_text.text = entry.text
