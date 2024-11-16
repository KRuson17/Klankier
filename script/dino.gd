extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("idle")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("deferred_dead", body)

func deferred_dead(body: Node2D):
	body.dead()
