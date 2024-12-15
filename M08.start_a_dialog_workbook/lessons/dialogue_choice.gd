@icon("res://assets/dialogue_choice_icon.svg")
class_name DialogueChoice extends Resource

@export_multiline var text:  String = ""
@export_range(0,20) var target_line_idx := 0
@export var is_quit := false
