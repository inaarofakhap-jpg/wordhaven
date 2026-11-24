extends Control

@onready var karakter_illit = $TextureProgressBar/karakterillit
@onready var label_question_title = $QuestionBar
@onready var label_question_text = $BoxQuestion/Question
@onready var btn_a = $VBoxContainer/Baris1/BtnOpsiA
@onready var btn_b = $VBoxContainer/Baris1/BtnOpsiB
@onready var btn_c = $VBoxContainer/Baris2/BtnOpsiC
@onready var btn_d = $VBoxContainer/Baris2/BtnOpsiD
@onready var btn_e = $VBoxContainer/BtnOpsiE # Tombol E full di bawah
@onready var progress_bar = $TextureProgressBar

# Daftar soal
var daftar_soal = []
var index_soal_saat_ini = 0
var skor = 0
var jawaban_benar_total = 0
var jawaban_salah_total = 0

func _ready() -> void:
	# Karena level hanya 1, langsung set karakter ILLIT tunggal (misal: Wonhee / level 1)
	karakter_illit.texture = load("res://assets/moka.png")
	daftar_soal = soal_kelas_x_level_1()
			
	if progress_bar:
		progress_bar.max_value = daftar_soal.size()
		
	# Background Quiz
	GlobalSound.play_bgm("res://assets/bgm_quiz.mp3")
	tampilkan_soal()

# Soal kelas X level 1 (Diperbarui dengan 5 pilihan: A sampai E)
func soal_kelas_x_level_1() -> Array:
	return [
	{
		"soal": "Hello, my name is Diana. ________ live in Bandung with my family.",
		"opsi": ["I", "Me", "My", "Mine", "Myself"],
		"jawaban": 0
	},
	{
		"soal": "Let me introduce my brother. ________ name is Farhan.",
		"opsi": ["His", "Him", "He", "Himself", "His's"],
		"jawaban": 0
	},
	{
		"soal": "Siti and her friends ________ to the library every Wednesday.",
		"opsi": ["goes", "went", "go", "going", "gone"],
		"jawaban": 2
	},
	{
		"soal": "We ________ a great movie at the cinema last night.",
		"opsi": ["watch", "watched", "watching", "watches", "watcher"],
		"jawaban": 1
	},
	{
		"soal": "You see your classmate carrying heavy books. What is the most appropriate offer of help?",
		"opsi": [
			"Can you help me carry these books?",
			"Would you like me to help you carry those books?",
			"I don't think you need help.",
			"You should carry the books faster.",
			"Help yourself with those books."
		],
		"jawaban": 1
	},
	{
		"soal": "A: 'I am feeling so thirsty.' \nB: '________ I get you a glass of water?'",
		"opsi": ["May", "Will", "Am", "Did", "Do"],
		"jawaban": 0
	},
	{
		"soal": "She bought a ________ bag at the local market yesterday.",
		"opsi": [
			"leather beautiful brown",
			"beautiful brown leather",
			"brown leather beautiful",
			"leather brown beautiful",
			"beautiful leather brown"
		],
		"jawaban": 1
	},
	{
		"soal": "They live in a ________ house near the park.",
		"opsi": [
			"small wooden old",
			"wooden small old",
			"small old wooden",
			"old wooden small",
			"old small wooden"
		],
		"jawaban": 2
	},
	{
		"soal": "My family and I ________ visit our grandparents next holiday.",
		"opsi": ["are going to", "went to", "have been", "visited", "will visiting"],
		"jawaban": 0
	},
	{
		"soal": "This notebook belongs to Rina. It is ________.",
		"opsi": ["her", "hers", "she", "herself", "it"],
		"jawaban": 1
	}
]

# Menampilkan Soal
func tampilkan_soal() -> void:
	if index_soal_saat_ini < daftar_soal.size():
		var soal_data = daftar_soal[index_soal_saat_ini]
		
		if label_question_title:
			label_question_title.text = "QUESTION " + str(index_soal_saat_ini + 1)
		if label_question_text:
			label_question_text.text = soal_data["soal"]
			
		btn_a.text = "A. " + soal_data["opsi"][0]
		btn_b.text = "B. " + soal_data["opsi"][1]
		btn_c.text = "C. " + soal_data["opsi"][2]
		btn_d.text = "D. " + soal_data["opsi"][3]
		btn_e.text = "E. " + soal_data["opsi"][4]
		
		reset_warna_tombol()
		aktifkan_tombol(true)
		
		# PROGRESS BAR DAN POSISI KARAKTER :
		if progress_bar:
			progress_bar.value = index_soal_saat_ini
			
		# Karakter ILLIT berjalan
		if karakter_illit:
			var posisi_awal_x = 50.0  
			var posisi_akhir_x = 690.0
			var progres_persen = float(index_soal_saat_ini) / float(daftar_soal.size())
			karakter_illit.position.x = posisi_awal_x + ((posisi_akhir_x - posisi_awal_x) * progres_persen)
	else:
		GlobalGame.skor_akhir = skor
		GlobalGame.benar_total = jawaban_benar_total
		GlobalGame.salah_total = jawaban_salah_total
		GlobalGame.total_soal = daftar_soal.size()
		
		get_tree().change_scene_to_file("res://score_page.tscn")

# Mengecek jawaban (mencakup opsi A, B, C, D, E)
func cek_jawaban(pilihan_index: int, tombol_pilih: Button) -> void:
	aktifkan_tombol(false)
	var soal_data = daftar_soal[index_soal_saat_ini]
	
	# Array daftar tombol untuk pencocokan jawaban benar
	var daftar_tombol = [btn_a, btn_b, btn_c, btn_d, btn_e]
	
	if pilihan_index == soal_data["jawaban"]:
		tombol_pilih.modulate = Color.GREEN
		skor += 10
		jawaban_benar_total += 1
	else:
		tombol_pilih.modulate = Color.RED
		jawaban_salah_total += 1
		var tombol_benar = daftar_tombol[soal_data["jawaban"]]
		tombol_benar.modulate = Color.GREEN

	GlobalSound.play_sfx_quiz() # khusus tombol kuis
	
	await get_tree().create_timer(1.2).timeout
	index_soal_saat_ini += 1
	tampilkan_soal()
	
func reset_warna_tombol() -> void:
	btn_a.modulate = Color.WHITE
	btn_b.modulate = Color.WHITE
	btn_c.modulate = Color.WHITE
	btn_d.modulate = Color.WHITE
	btn_e.modulate = Color.WHITE

func aktifkan_tombol(status: bool) -> void:
	btn_a.disabled = !status
	btn_b.disabled = !status
	btn_c.disabled = !status
	btn_d.disabled = !status
	btn_e.disabled = !status

func _on_btn_opsi_a_pressed() -> void: cek_jawaban(0, btn_a)
func _on_btn_opsi_b_pressed() -> void: cek_jawaban(1, btn_b)
func _on_btn_opsi_c_pressed() -> void: cek_jawaban(2, btn_c)
func _on_btn_opsi_d_pressed() -> void: cek_jawaban(3, btn_d)
func _on_btn_opsi_e_pressed() -> void: cek_jawaban(4, btn_e)
# Go to Home

func _on_btn_home_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_btn_back_pressed() -> void:
	GlobalSound.play_sfx_menu()
	get_tree().change_scene_to_file("res://latihan_soal.tscn")
