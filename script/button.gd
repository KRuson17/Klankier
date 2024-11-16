extends TextureButton

var mode : int

func init(_mode: int):
	mode = _mode
	update_texture()

func update_texture():
	var path = "res://asset/arena/ikonki" + str(mode) + ".png"
	var texture = load(path)
	texture_normal = texture


func _on_pressed() -> void:
	get_parent().get_parent().click(mode)
