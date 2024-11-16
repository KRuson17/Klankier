extends CharacterBody2D

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
	if canMove:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		move_and_slide()
		#upadek
		if position.y > 720:
			dead()

func dead():
	get_tree().reload_current_scene()

func win1():
	call_deferred("deferred_change_scene")

func deferred_change_scene():
	get_tree().change_scene_to_file("res://Sceny/Q2/world_2.tscn")
	
func win2():
	print("WIN.LEVEL2")
	canMove = false
