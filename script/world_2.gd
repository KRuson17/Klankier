extends Node2D

var point = 0
var pointerToChat
var canMove = false
var pointerToPlayer
var cameraSpeed = 1

@onready var parallax_background = $ParallaxBackground
@onready var player = $player

func _init() -> void:
	#start()
	pass

func start():
	$Timer2.autostart = false
	$player.canMove = false
	pointerToPlayer = get_node("player")
	var tmpchat = preload("res://Sceny/Q2/chat.tscn").instantiate()
	tmpchat.position = Vector2(0,-50)
	pointerToPlayer.add_child(tmpchat)
	pointerToPlayer.Camera.enabled = false
	pointerToChat = tmpchat
	$Timer2.wait_time = 3
	point = 1
	$Timer2.start()

func _process(_delta: float) -> void:
	if canMove:
		moveCamera()
		if $Camera2D.position.x > 4800:
			canMove = false
			pointerToPlayer.win2()
			pointerToChat.get_node("Label").text = "Uff, udało mi się uciec do bezpiecznej jaskini."
			pointerToChat.visible = true
			$Timer2.wait_time = 3
			$Timer2.start()
			point = 5
		
		var player_position = player.position.x
		parallax_background.scroll_offset.x = player_position * 0.5
	

func moveCamera():
	$Camera2D.position += Vector2(cameraSpeed,0)


func _on_timer_timeout() -> void:
	match point:
		0:
			start()
		1:
			pointerToChat.visible = false
			get_node("chatDino").visible = true
			$Timer2.wait_time = 3
			$Timer2.start()
			point = 2
		2:
			get_node("chatDino").visible = false
			pointerToChat.get_node("Label").text = "O nie, Dinozaur. Muszę uciekać"
			get_node("Camera2D").get_node("dino").visible = true
			pointerToChat.visible = true
			$Timer2.wait_time = 3
			$Timer2.start()
			point = 3
		3:
			pointerToChat.visible = false
			$player.canMove = true
			canMove = true
			$Timer2.wait_time = 3
			$Timer2.autostart = true
			point = 4
			$Timer2.start()
		4:
			if cameraSpeed >= 1.75:
				$Timer2.autostart = false
			cameraSpeed += 0.25
		5:
			$Timer2.autostart = false
			pointerToChat.get_node("Label").text = "Teraz mogę użyć czasozmieniacza"
			pointerToChat.visible = true
			$Timer2.wait_time = 3
			var portal = preload("res://Sceny/Q2/portal.tscn")
			portal = portal.instantiate()
			portal.position = pointerToPlayer.position
			portal.z_index = pointerToPlayer.z_index - 1
			add_child(portal)
			$Timer2.start()
			point = 6
		6:
			$Timer2.stop()
			print("ładuj poziom 3")
			var world_3_scene = preload("res://Sceny/Q3/world_3.tscn").instantiate()
			world_3_scene.bones = $player.bone_counter
			get_tree().root.add_child(world_3_scene)
			queue_free()
			get_tree().current_scene = world_3_scene
