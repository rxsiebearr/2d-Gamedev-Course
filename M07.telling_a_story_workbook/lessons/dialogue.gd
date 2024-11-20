extends Control

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var body: TextureRect = %Body
@onready var expression: TextureRect = %Expression

var expressions := {
	"happy": preload("res://assets/emotion_happy.png"),
	"regular": preload("res://assets/emotion_regular.png"),
	"sad": preload("res://assets/emotion_sad.png"),
}

var bodies := {
	"sophia": preload("res://assets/sophia.png"),
	"pink": preload("res://assets/pink.png"),
}
var dialogue_items: Array[Dictionary] = [
{
	"expression": expressions["happy"],
	"text": "[rainbow val = 0.8]LALALALA[/rainbow]",
	"character": bodies["sophia"],
},
{
	"expression": expressions["happy"],
	"text": "[wave][rainbow val = 0.8]LALALALA[/rainbow][/wave]",
	"character": bodies["pink"],
},
{
	"expression": expressions["regular"],
	"text": "[tornado freq = 1.0]Elmos World![/tornado]",
	"character": bodies["sophia"],
},
{
	"expression": expressions["regular"],
	"text": "[shake](Elmos World!)[/shake]",
	"character": bodies["pink"],
},
{
	"expression": expressions["happy"],
	"text": "[b][rainbow val = 0.8]LALALALA[/rainbow][/b]",
	"character": bodies["sophia"],
},
{
	"expression": expressions["happy"],
	"text": "[b][rainbow val = 0.8][i]LALALALA[/i][/rainbow][/b]",
	"character": bodies["pink"],
},
{
	"expression": expressions["regular"],
	"text": "[wave]Elmos World! (Elmos World)[/wave]",
	"character": bodies["sophia"],
},
{
	"expression": expressions["sad"],
	"text": "[color=FF8C00]Elmo loves his goldfish![/color]",
	"character": bodies["pink"],
},
{	
	"expression": expressions["happy"],
	"text": "[color=FF0000]His crayon too![/color]",
	"character": bodies["sophia"],
},
{
	"expression": expressions["regular"],
	"text": "[rainbow val = 0.8]...[/rainbow]",
	"character": bodies["sophia"]
},
{
	"expression": expressions["happy"],
	"text": "[color=FF69B4]And that's Elmo's World!![/color]",
	"character": bodies["pink"],
},
{
	"expression": expressions["happy"],
	"text": "[b][color=00BFFF]YEAH![/color][b]",
	"character": bodies["sophia"],
}
]

var current_item_index := 0

func show_text() -> void:
	var current_item := dialogue_items[current_item_index]
	rich_text_label.text = current_item["text"]
	expression.texture = current_item["expression"]
	body.texture = current_item["character"]
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearing_duration : float = current_item["text"].length() / 20.0
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearing_duration)
	var sound_max_length := audio_stream_player.stream.get_length() - text_appearing_duration
	var sound_start_position := randf() * sound_max_length
	audio_stream_player.play(sound_start_position)
	tween.finished.connect(audio_stream_player.stop)
	slide_in()
	next_button.disabled = true
	tween.finished.connect(
		func() -> void:
			next_button.disabled = false
	)
	
	
func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)
	
func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else: 
		show_text()
	
func slide_in() -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	body.position.x = 200.0
	tween.tween_property(body, "position:x", 0.0, 0.3)
	body.modulate.a = 0.0
	tween.parallel().tween_property(body, "modulate:a", 1.0, 0.2)
