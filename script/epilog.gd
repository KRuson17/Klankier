extends Node2D

var portalR = true
var walk = 700
var point = 1

func _ready() -> void:
	music.play_music(preload("res://sounds/epilog.ogg"),"epilog.tscn")
	$AnimatedSprite2D.play("run")


func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		if $Timer.is_stopped() == false:
			_on_timer_timeout()
	if portalR:
		$portal.rotation_degrees += 2 if $portal.rotation_degrees >= 360 else 2
	if walk > 0:
		$AnimatedSprite2D.position += Vector2(2,0)
		walk -= 2
		if walk == 350:
			$chat.visible = true
			$chat/Label.text = "W końcu w domu"
		if walk == 0:
			walk = -1
			$AnimatedSprite2D.play("idle")
			_on_timer_timeout()


func _on_timer_timeout() -> void:
	match point:
		1:
			$chat/Label.text = "Ależ to była przygoda"
			point = 2
			$Timer.start()
			portalR = false
			$portal.visible = false
		2:
			$chat/Label.text = "Było świetnie"
			point = 3
		3:
			$chat/Label.text = "Zgubiłem się w czasie, ale udało się wrócić do domu"
			point = 99
		99:
			$Button.visible = true


func _on_button_button_down() -> void:
	music.play_music(preload("res://sounds/menu.wav"),"menu.tscn")
	var menu_scene = preload("res://Sceny/menu.tscn").instantiate()
	menu_scene.openC = true
	get_tree().root.add_child(menu_scene)
	queue_free()
	get_tree().current_scene = menu_scene
