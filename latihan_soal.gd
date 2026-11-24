extends Control

# Go to Home
func _on_btn_home_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://main_menu.tscn")

# Kembali halaman
func _on_btn_back_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://menu_selection.tscn")
	
# icon Level 1 
func _on_btn_level_1_pressed() -> void:
	GlobalGame.menu_terpilih = "Latihan Soal"
	GlobalGame.level_terpilih = 1
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://quiz_page.tscn")

# Background Sound
func _ready() -> void:
	GlobalSound.play_bgm("res://assets/bgm_menu.mp3")
