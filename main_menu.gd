extends Control
@onready var popup_custom = $PopupCustom
# tombol START diklik
func _on_btn_start_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://menu_selection.tscn")

# tombol Profile diklik
func _on_btn_profile_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://profile_page.tscn")

# tombol EXIT diklik
func _on_btn_exit_pressed() -> void:
	GlobalSound.play_sfx_menu()
	popup_custom.visible = true

func _on_ya_pressed() -> void:
	get_tree().quit()
	GlobalSound.play_sfx_menu()

func _on_tidak_pressed() -> void:
	popup_custom.visible = false
	GlobalSound.play_sfx_menu()

func _on_btn_silang_pressed() -> void:
	popup_custom.visible = false
	GlobalSound.play_sfx_menu()

# Background Sound
func _ready() -> void:
	GlobalSound.play_bgm("res://assets/bgm_menu.mp3")
	popup_custom.visible = false
