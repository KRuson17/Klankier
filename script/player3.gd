extends AnimatedSprite2D

var button_instance = preload("res://Sceny/Q3/button.tscn")
var tableB = []
var hasBone = false

func setButton():
	for i in range(1,4):
		var tmp = button_instance.instantiate()
		tmp.init(i)
		tmp.position = Vector2((i - 1) * 200 - 285, -400)
		tmp.scale.x = 3
		tmp.scale.y = 3
		add_child(tmp)
		tableB.append(tmp)
	if hasBone:
		var tmp = button_instance.instantiate()
		tmp.init(4)
		tmp.position = Vector2(315, -400)
		tmp.scale.x = 3
		tmp.scale.y = 3
		add_child(tmp)
		tableB.append(tmp)
	elif tableB.size()==4:
		tableB.remove_at(3)

func checkBone():
	if !hasBone and tableB.size() == 4:
		tableB.remove_at(3)

func showButton(q = true):
	if q:
		checkBone()
	for i in range(tableB.size()):
		tableB[i].visible = q
