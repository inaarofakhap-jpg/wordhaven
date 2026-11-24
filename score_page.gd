extends Control

@onready var label_nilai = $ScoreBox/Nilai 
@onready var label_benar = $ScoreBox/correct/NilaiBenar   
@onready var label_salah = $ScoreBox/Wrong/NilaiSalah     
@onready var label_pertanyaan = $ScoreBox/Questions/JumlahPertanyaan 
@onready var popup_custom = $PopupCustom

func _ready() -> void:
	# Cek data yang masuk di panel Output bawah
	print("--- DATA DI SCORE PAGE ---")
	print("Skor Akhir: ", GlobalGame.skor_akhir)
	print("Jawaban Benar: ", GlobalGame.benar_total)
	print("Jawaban Salah: ", GlobalGame.salah_total)
	
	if label_nilai:
		label_nilai.text = str(GlobalGame.skor_akhir) + " / " + str(GlobalGame.total_soal * 10)
	
	if label_benar:
		label_benar.text = str(GlobalGame.benar_total)
		
	if label_salah:
		label_salah.text = str(GlobalGame.salah_total)
		
	if label_pertanyaan:
		label_pertanyaan.text = str(GlobalGame.total_soal)

	if has_node("Home"):
		$Home.pressed.connect(_on_home_pressed)

#  Background Sound
	GlobalSound.play_bgm("res://assets/bgm_menu.mp3")
	popup_custom.visible = false

# amain lagi
func _on_btn_play_again_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://latihan_soal.tscn")

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

# Go to Home
func _on_home_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://main_menu.tscn")

# Kembali halaman
func _on_btn_back_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://quiz_page.tscn")
