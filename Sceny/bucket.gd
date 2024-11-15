extends Area2D

var hold = true

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and hold:
		var tmpBucket = preload("res://Sceny/bucket.tscn")
		tmpBucket = tmpBucket.instantiate()
		tmpBucket.hold = false
		tmpBucket.position += Vector2(0,-40)
		body.call_deferred("add_child", tmpBucket)
		queue_free()
