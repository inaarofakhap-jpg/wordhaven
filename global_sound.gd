extends Node

var bgm_player = AudioStreamPlayer.new()
var sfx_player = AudioStreamPlayer.new()

func _ready() -> void:
	add_child(bgm_player)
	add_child(sfx_player)
	bgm_player.bus = "Master"
	sfx_player.bus = "Master"

func play_bgm(file_path: String) -> void:
	if bgm_player.playing and bgm_player.stream and bgm_player.stream.resource_path == file_path:
		return
	
	var stream = load(file_path)
	if stream:
		if stream is AudioStreamMP3:
			stream.loop = true
			
		bgm_player.stream = stream
		bgm_player.play()

func play_sfx_menu() -> void:
	var stream = load("res://assets/sfx_menu.mp3") 
	if stream:
		sfx_player.stream = stream
		sfx_player.play()

func play_sfx_quiz() -> void:
	var stream = load("res://assets/sfx_quiz_click.mp3") 
	if stream:
		sfx_player.stream = stream
		sfx_player.play()
