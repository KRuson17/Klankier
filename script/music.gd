extends AudioStreamPlayer


var current_scene_name: String = "world1" # Domyślna scena

func play_music(stream: AudioStream, scene_name: String) -> void:
	if scene_name != current_scene_name:
		current_scene_name = scene_name
		stop()
		self.stream = stream
		play()
