extends Node2D

var point = 0
var sz_closed = preload("res://asset/prolog/szuflada_closed.png")
var sz_open = preload("res://asset/prolog/szuflada.png")
var portalR = false
var notes = false
var movePlayer = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$szuflada.texture_normal = sz_closed
	start()

func start():
	$chat/Label.text = "W końcu skończyłem obliczenia do czasozmieniacza"
	$chat.visible = true
	$Timer.start()

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		if $Timer.is_stopped() == false:
			_on_timer_timeout()
	if portalR:
		$portal.rotation_degrees += 2 if $portal.rotation_degrees >= 360 else 2
	if notes:
		$Book.position = $Book.position.move_toward($portal.position, 1)
		if $Book.position == $portal.position:
			notes = false
			$Book.visible = false
	if movePlayer:
		$AnimatedSprite2D.position = $AnimatedSprite2D.position.move_toward($portal.position, 1)
		if $AnimatedSprite2D.position == $portal.position:
			get_tree().change_scene_to_file("res://Sceny/Q1/world1.tscn")


func _on_timer_timeout() -> void:
	match point:
		0:
			$chat/Label.text = "Teraz będę mógł podróżować w czasie"
			point = 1
		1:
			$chat/Label.text = "Muszę tylko znaleźć czasozmieniacz"
			point = 2
		2:
			$chat/Label.text = "Chyba schowałem go w szufladzie"
			$Timer.stop()
			$szuflada.visible = true
		3:
			$Timer.wait_time = 3
			$chat/Label.text = "Uwaga. Uruchamiamy"
			point = 4
		4:
			$chat/Label.text = "Super, działa. Otworzył się portal"
			$portal.visible = true
			point = 5
		5:
			portalR = true
			$chat/Label.text = "O nie, portal jest niestabilny"
			point = 6
		6:
			$chat/Label.text = "Muszę wprowadzić poprawki z notatek"
			point = 7
		7:
			$chat/Label.text = "O nie moje notatki"
			point = 8
			notes = true
		8:
			$chat/Label.text = "No nic, ku przygodzie"
			movePlayer = true
			$Timer.stop()


func _on_texture_button_pressed() -> void:
	$TextureButton.visible = false
	point = 3
	$Timer.wait_time = 0.001
	$Timer.start()

func _on_szuflada_button_down() -> void:
	if $szuflada.texture_normal == sz_open:
		$szuflada.visible = false
		$TextureButton.visible = true
		$chat/Label.text = "Czas go uruchomić"
	
	if $szuflada.texture_normal == sz_closed:
		$szuflada.texture_normal = sz_open
		$szuflada.position = Vector2(313, 397)
		$chat/Label.text = "O, jest tutaj"
