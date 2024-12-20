extends Area2D

@export var rangeToMove = [0, 200]
var direc = true
var step = 1
func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _process(_delta: float) -> void:
	if abs(rangeToMove[0]) >= abs(rangeToMove[1]):
		direc = !direc
	step = 1 if direc else -1
	$AnimatedSprite2D.flip_h = false if step > 0 else true
	position += Vector2(step, 0)
	rangeToMove[0] += step


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("dead")
		
func dead():
	get_tree().reload_current_scene()
