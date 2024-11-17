extends Node2D

var point = 0

func _ready() -> void:
	$woman/chat/Label.text = ""
	$player/chat/Label.text = "Kolejny skok"
	$Timer.start()

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		if $Timer.is_stopped() == false:
			_on_timer_timeout()

func startCorset():
	$corset.visible = true
	$corset.start()

func endCorset():
	$corset.visible = false
	_on_timer_timeout()

func _on_timer_timeout() -> void:
	match point:
		0:
			$player/portal.visible = false
			$player/chat/Label.text = "To nie jest mój dom, ani mój czas"
			point = 1
		1:
			$woman/chat/Label.text = "Kim jesteś i czego tu szukasz"
			$woman/chat.visible = true
			$player/chat.visible = false
			point = 2
		2:
			$woman/chat.visible = false
			$player/chat.visible = true
			$player/chat/Label.text = "Szukam swoich notatek by móc wrócić do domu"
			point = 3
		3:
			$woman/chat/Label.text = "Znalazłam jakieś niezrozumiałe papiery i schowałam pod gosetem"
			$woman/chat.visible = true
			$player/chat.visible = false
			point = 4
		4:
			$woman/chat/Label.text = "Będziesz musiał mi pomóc"
			$Timer.stop()
			point = 5
			startCorset()
		5:
			$woman/chat/Label.text = "A oto twoje notatki"
			$woman/chat.visible = true
			$player/chat.visible = false
			point = 6
			$winbutton.visible = true
			$Timer.stop()
		6:
			$winbutton.visible = false
			$woman/chat.visible = false
			$player/chat.visible = true
			$player/chat/Label.text = "Dziękuję, :hot_face:"
			point = 7
			$Timer.start()
		7:
			$player/chat/Label.text = "To ja wracam do swoich czasów"
			point = 8
			$player/portal.visible = true
		8:
			get_tree().change_scene_to_file("res://Sceny/epilog.tscn")

func _on_winbutton_pressed() -> void:
	_on_timer_timeout()
