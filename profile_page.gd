extends Control

# Go to Home
func _on_home_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://main_menu.tscn")

# Background Sound
func _ready() -> void:
	GlobalSound.play_bgm("res://assets/bgm_menu.mp3")
