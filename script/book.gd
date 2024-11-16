extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("WIN.LEVEL1")
		queue_free()
		body.win1()
		
