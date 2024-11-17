extends AudioStreamPlayer


var current_scene_name: String = "menu" # Domyślna scena


func play_music(new_stream: AudioStream, scene_name: String) -> void:
	if scene_name != current_scene_name:
		current_scene_name = scene_name
		stop()
		self.stream = new_stream  # Ustawiamy strumień z nową muzyką
		play()
	


func _on_finished() -> void:
	play()
