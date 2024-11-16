extends Sprite2D

@export var speed = 2

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	rotation_degrees += speed if rotation_degrees >= 360 else speed
