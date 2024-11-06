extends ColorRect

var items: Array[String] = [
	"Strings. Ints. Floats. Nulls.",
	"Long ago, the four types lived together in harmony.",
	"Then, everything changed when the typed Array arrived.",
	"Only the Programmer, student of all types, could stop them.",
	"But when the world needed them most, they were studying on GDQuest.",
]
var item_index := 0

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var button: Button = %Button

func show_text() -> void:
	rich_text_label.text = items[item_index]

func _ready() -> void:
	show_text()
	button.pressed.connect(advance)

# Increments the index each time is called.
func advance() -> void:
	item_index += 1
	if item_index >= items.size() - 1:
		item_index = 0
	show_text()
