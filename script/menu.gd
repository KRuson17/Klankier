extends Control

@export var speed = 1

func _ready() -> void:
	music.play_music(preload("res://sounds/menu.wav"),"menu.tscn")
	

func _process(_delta: float) -> void:
	$Sprite2D.rotation_degrees += speed if $Sprite2D.rotation_degrees >= 360 else speed


func _on_texture_button_pressed() -> void:
	music.play_music(preload("res://sounds/music1.mp3"),"world1.tscn")
	get_tree().change_scene_to_file("res://Sceny/Q1/world1.tscn")

func _on_texture_button_2_pressed() -> void:
	music.play_music(preload("res://sounds/music2.ogg"),"world_2.tscn")
	get_tree().change_scene_to_file("res://Sceny/Q2/world_2.tscn")

func _on_texture_button_3_pressed() -> void:
	music.play_music(preload("res://sounds/music3.mp3"),"world_3.tscn")
	get_tree().change_scene_to_file("res://Sceny/Q3/world_3.tscn")

func _on_texture_button_4_pressed() -> void:
	music.play_music(preload("res://sounds/music4.ogg"),"world_4.tscn")
	get_tree().change_scene_to_file("res://Sceny/Q4/world_4.tscn")

func _on_button_pressed() -> void:
	music.play_music(preload("res://sounds/prolog.ogg"),"prolog.tscn")
	get_tree().change_scene_to_file("res://Sceny/prolog.tscn")

func _on_button_2_pressed() -> void:
	$ButtonContainer.visible = false
	$SelectContainer.visible = true
	$Back.visible = true

func _on_button_3_pressed() -> void:
	$ButtonContainer.visible = false
	$Name.visible = true
	$Back.visible = true

func _on_button_4_pressed() -> void:
	get_tree().quit()

func _on_back_pressed() -> void:
	$SelectContainer.visible = false
	$ButtonContainer.visible = true
	$Back.visible = false
	$Name.visible = false
