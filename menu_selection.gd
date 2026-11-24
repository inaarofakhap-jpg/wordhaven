extends Control

# Go to Home
func _on_home_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://main_menu.tscn")

# ikon diklik
func _on_icon_ls_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://latihan_soal.tscn")

# Tombol Kembali Ke Halaman Sebelumnya
func _on_btn_back_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://main_menu.tscn")
	
# Background Sound
func _ready() -> void:
	GlobalSound.play_bgm("res://assets/bgm_menu.mp3")
