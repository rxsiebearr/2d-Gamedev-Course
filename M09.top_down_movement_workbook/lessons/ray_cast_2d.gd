extends RayCast2D

@onready var ray_cast_2d: RayCast2D = %RayCast2D

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position()
