extends Control

@export var speed = 1
var openC

func _init() -> void:
	if openC:
		pass#openCredits

func _ready() -> void:
	music.play_music(preload("res://sounds/menu.wav"),"menu.tscn")


func _process(_delta: float) -> void:
	$Sprite2D.rotation_degrees += speed if $Sprite2D.rotation_degrees >= 360 else speed
