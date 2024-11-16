extends Area2D

func _ready() -> void:
	$Sprite2D.play("default")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.hasBucket:
			for child in body.get_children():
				if child.is_in_group("bucket"):
					child.queue_free()
					break
			call_deferred("queue_free")
		else:
			call_deferred("dead")

func dead():
	get_tree().reload_current_scene()
