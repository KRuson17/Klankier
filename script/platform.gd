extends StaticBody2D

@export var rangeToMove = [0, 200]
var direc = true
var step = 1

func _process(_delta: float) -> void:
	if abs(rangeToMove[0]) >= abs(rangeToMove[1]):
		direc = !direc
	step = 1 if direc else -1
	position += Vector2(step, 0)
	rangeToMove[0] += step
