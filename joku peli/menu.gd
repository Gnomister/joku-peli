extends Node

#alottaa pelin ja vaihtaa scenen
func _on_playbutton_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
