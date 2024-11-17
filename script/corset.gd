extends Node2D

@export var tableHole: Array[TextureButton]
@export var barTexture: Texture
var playTable = []
var holePNG = [preload("res://asset/corset/hole.png"), preload("res://asset/corset/hole_show.png")]
var cor = [preload("res://asset/corset/corset-tighten.png"),preload("res://asset/corset/corset.png")]
var target_index: int = -1
var current_click_index: int = 0
var bars = []

var tmp = 1

func _ready() -> void:
	pass#start()

func start(m):
	tmp = m
	
	# Reset playTable na pustą listę
	playTable.clear()
	for i in range(10):
		remove_bar()
	current_click_index = 0
	if tmp == 2:
		$Sprite2D.texture = cor[0]
	for i in range(10):
		playTable.append(i)
	playTable = shuffle_alternate_random(playTable)
	
	for i in range(tableHole.size()):
		tableHole[i].connect("pressed", Callable(self, "_on_button_pressed").bind(i))
	
	set_buttons_active(false)
	showAllHole()
	set_target_button()
	add_bars_between_buttons()


func shuffle_alternate_random(original_table: Array) -> Array:
	var first_half = original_table.slice(0, original_table.size() / 2)
	var second_half = original_table.slice(original_table.size() / 2, original_table.size())
	var shuffled_table = []

	while first_half.size() > 0 or second_half.size() > 0:
		if first_half.size() > 0:
			var random_first = randi() % first_half.size()
			shuffled_table.append(first_half[random_first])
			first_half.remove_at(random_first)
		if second_half.size() > 0:
			var random_second = randi() % second_half.size()
			shuffled_table.append(second_half[random_second])
			second_half.remove_at(random_second)

	return shuffled_table

func showAllHole():
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = true
	add_child(timer)

	for i in range(playTable.size()):
		tableHole[playTable[i]].texture_normal = holePNG[1]
		timer.start()
		await timer.timeout
		tableHole[playTable[i]].texture_normal = holePNG[0]

	set_buttons_active(true)
	timer.queue_free()

	print("Czekam na kliknięcie przycisków w kolejności:", playTable)

func set_buttons_active(is_active: bool):
	for button in tableHole:
		button.disabled = !is_active

func _on_button_pressed(index: int) -> void:
	if index == playTable[current_click_index]:
		_handle_correct_button(index)
	else:
		_handle_wrong_button(index)

func set_target_button():
	if current_click_index < playTable.size():
		print("Czekam na kliknięcie przycisku:", playTable[current_click_index])

func _handle_correct_button(index: int):
	print("Kliknięto poprawny przycisk:", index)
	current_click_index += 1

	if current_click_index == playTable.size():
		_handle_game_over(true)
	else:
		set_target_button()

	remove_bar()

func _handle_wrong_button(index: int):
	print("Kliknięto niewłaściwy przycisk:", index)
	_handle_game_over()

func _handle_game_over(q = false):
	tmp += 1
	if !q:
		print("Gra zakończona!")
		get_parent().endCorset((tmp-1)*-1)
	else:
		print("Gra zakończona sukcesem")
		get_parent().endCorset(tmp-1)

func add_bars_between_buttons():
	for i in range(playTable.size() - 1):
		var bar = Sprite2D.new()
		bar.texture = barTexture
		var pos_start = tableHole[playTable[i]].global_position
		var pos_end = tableHole[playTable[i + 1]].global_position
		bar.position = pos_start.lerp(pos_end, 0.5)
		bar.position += Vector2(30, 30)
		var direction = pos_end - pos_start
		bar.rotation = direction.angle()
		var desired_length_in_pixels = direction.length()
		var scale_x = desired_length_in_pixels / bar.texture.get_width()
		bar.scale.x = scale_x
		add_child(bar)
		bars.append(bar)

func remove_bar():
	if bars.size() > 0:
		var bar = bars.pop_front()
		bar.queue_free()
