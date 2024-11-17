extends CharacterBody2D

var on_ladder: bool = false
var hasBucket = false
var canMove = true
var point = 0
var pointerToChat
var Camera
var bone_counter = 0

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	Camera = get_node("Camera2D")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Sceny/menu.tscn")
		
	if canMove:
		if on_ladder:
			# Wyłącz grawitację
			velocity.y = 0

			# Ruch góra/dół na drabinie
			var vertical_direction = Input.get_axis("ui_up", "ui_down")
			velocity.y = vertical_direction * SPEED
			
			var horizontal_direction = Input.get_axis("ui_left", "ui_right")
			velocity.x = horizontal_direction * SPEED
			
			# Animacja wspinania się
			if vertical_direction != 0:
				pass#$AnimatedSprite2D.play("climb")
			else:
				$AnimatedSprite2D.play("idle")
		else:
			# Grawitacja działa, jeśli nie jesteśmy na drabinie
			if not is_on_floor():
				velocity += get_gravity() * delta

			# Ruch poziomy i animacje
			var direction = Input.get_axis("ui_left", "ui_right")
			if direction:
				velocity.x = direction * SPEED
				$AnimatedSprite2D.play("run")
				$AnimatedSprite2D.flip_h = direction < 0
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				$AnimatedSprite2D.play("idle")

			# Skok (tylko poza drabiną)
			if Input.is_action_just_pressed("ui_accept") and is_on_floor():
				velocity.y = JUMP_VELOCITY

		move_and_slide()

		# Upadek
		if position.y > 720:
			dead()

func dead():
	get_tree().reload_current_scene()

func win1():
	call_deferred("deferred_change_scene")

func deferred_change_scene():
	music.play_music(preload("res://sounds/music2.ogg"),"world_2.tscn")
	get_tree().change_scene_to_file("res://Sceny/Q2/world_2.tscn")
	
func win2():
	print("WIN.LEVEL2")
	canMove = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("ladder"):
		on_ladder = true
		velocity = Vector2.ZERO


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("ladder"):
		on_ladder = false


func _on_timer_timeout() -> void:
	$Timer.stop()
	$chat.visible = false
