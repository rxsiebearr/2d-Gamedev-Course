extends Control

var dialogue_items: Array[String] = [
	"LALALALA LALALALA",
	"Elmos World! (Elmos World)",
	"LALALALA LALALALA",
	"Elmos World! (Elmos World)",
	"Elmo loves his goldfish!",
	"His crayon too!",
	"...",
	"And that's Elmo's World!!",
	"YEAH!",
]
var current_item_index := 0
@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton

func show_text() -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item
	
func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)
	
func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else: show_text()
	
