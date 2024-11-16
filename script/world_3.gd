extends Node2D

var point = 0
var tura = 1
var enemy
var bar = []
var bones = 0

func _ready() -> void:
	$king.play("talk")
	$Timer.start()
	bar = [$shitBar, $shitBar2]
	bones = 1
	if bones > 0:
		$player.hasBone = true

func startFight(_enemy):
	point = null
	enemy = _enemy
	showBar(true)
	$player.showButton(true)
	$enemyOnSand.visible = true
	$enemyOnSand.play(str(enemy))

func click(button: int):
	$player.showButton(false)
	match button:
		1:
			if enemy%2==0:
				demage(10)
			else:
				demage(20)
		2:
			if enemy == 1:
				demage(20)
			elif enemy == 3:
				demage(15)
			else:
				demage(5)
		3:
			if enemy == 1:
				demage(10)
			elif enemy == 3:
				demage(5)
			else:
				demage(20)
		4:
			bones -= 1
			if bones == 0:
				$player.hasBone = false
			demage(80)

func enemydemage():
	var life = (randi() % 4 + 1) * 5
	var tmpstring = str(enemy)+"A"
	$enemyOnSand.play(tmpstring)
	$Timer.wait_time = 1
	point = 67
	$Timer.start()
	bar[0].value -= life * enemy+1

func demage(life: int):
	$player.play("atack")
	$Timer.wait_time = 1
	point = 66
	$Timer.start()
	bar[1].value -= life

func checkLife():
	for i in range(2):
		if bar[i].value <= 0:
			if i%2 == 0:
				die()
			else:
				return false
	return true

func nextEnemy():
	showBar(false)
	$player.showButton(false)
	$enemyOnSand.visible = false
	match enemy:
		0:
			point = 4
			$Timer.wait_time = 0.01
			$Timer.start()
		1:
			point = 6
			$Timer.wait_time = 0.01
			$Timer.start()
		2:
			point = 8
			$Timer.wait_time = 0.01
			$Timer.start()

func showBar(q = true):
	for i in range(2):
		bar[i].value = 100
		bar[i].visible = q

func die():
	get_tree().reload_current_scene()

func _on_timer_timeout() -> void:
	match point:
		0:
			$player/portal.visible = false
			$king.play("idle")
			$king/chat.visible = false
			$player/chat.visible = true
			point = 1
			$Timer.start()
		1:
			$king.play("talk")
			$king/chat.visible = true
			$king/chat/Label.text = "Mamy pierwszego śmiałka, który zawalczy o tę magiczną książkę Dajcie mu broń i zaczynamy"
			$player/chat.visible = false
			point = 2
			$Timer.start()
		2:
			$king.play("idle")
			$king/chat.visible = false
			$player/chat/Label.text = "Chyba muszę wygrać by móc wrócić do swoich czasów"
			$player/chat.visible = true
			point = 3
			$Timer.start()
		3:
			$player/chat.visible = false
			$player.setButton()
			startFight(0)
		4:
			$Timer.wait_time = 3
			$king.play("talk")
			$king/chat.visible = true
			$king/chat/Label.text = "Nowy wygrał. Wprowadzić kolejnego zawodnika"
			point = 5
			$Timer.start()
		5:
			$Timer.stop()
			point = null
			$king.play("idle")
			$king/chat.visible = false
			$player.showButton(true)
			startFight(1)
		6:
			$Timer.wait_time = 3
			$king.play("talk")
			$king/chat.visible = true
			$king/chat/Label.text = "Kolejne zwycięstwo. Ciekawe czy podoła naszemu czempionowi"
			point = 7
			$Timer.start()
		7:
			$Timer.stop()
			point = null
			$king.play("idle")
			$king/chat.visible = false
			$player.showButton(true)
			startFight(2)
		8:
			$Timer.wait_time = 3
			$king.play("talk")
			$king/chat.visible = true
			$king/chat/Label.text = "Cóż za piękne zwycięstwo"
			point = 9
			$Timer.start()
		9:
			$king.play("idle")
			$king/chat.visible = false
			$player/chat/Label.text = "Dziękuję."
			$player/chat.visible = true
			point = 10
			$Timer.start()
		10:
			$king.play("talk")
			$player/chat.visible = false
			$king/chat.visible = true
			$king/chat/Label.text = "A oto twoja nagroda"
			point = 11
		11:
			$king.play("idle")
			$king/chat.visible = false
			$winbutton.visible = true
		12:
			win3()
		66:
			$player.play("idle")
			point = null
			if checkLife():
				enemydemage()
			else:
				nextEnemy()
		67:
			$enemyOnSand.play(str(enemy))
			point = null
			if checkLife():
				$player.showButton(true)
			else:
				nextEnemy()
		_:
			pass


func _on_winbutton_pressed() -> void:
	$player/portal.visible = true
	$winbutton.visible = false
	$Timer.start()
	point = 12

func win3():
	print("WIN.LEVEL3")
	for child in get_children():
		child.queue_free()
	var l = Label.new()
	l.text = "NASTĘPNY POZIOM"
	add_child(l)
