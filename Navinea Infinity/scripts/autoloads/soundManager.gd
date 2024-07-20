extends Node

@onready var musicPlayer = $MusicPlayer;
var musicQueue: Array[String] = []

var sfx: Dictionary = {
	"explosion": {
		"path": "res://assets/sounds/sfx/8- bit explosion.mp3",
		"volume": -10
	},
	"damage": {
		"path": "res://assets/sounds/sfx/8-bit hit.mp3",
		"volume": 24
	},
	"shoot": {
		"path": "res://assets/sounds/sfx/8bit shoot.MP3",
		"volume": -5
	}
};

var musics: Dictionary = {
	"menu": {
		"path": "res://assets/sounds/musics/Swan Lake Theme.mp3",
		"volume": -10
	},
	"menu2": {
		"path": "res://assets/sounds/musics/music menu 2.MP3",
		"volume": -10
	}
};


func playSfx(sfxName: String) -> void:
	var audioPlayer := AudioStreamPlayer.new()
	
	var sound = ResourceLoader.load(sfx[sfxName]["path"])
	var soundVolume = sfx[sfxName]["volume"]
	
	audioPlayer.set_volume_db(soundVolume)
	audioPlayer.set_stream(sound)
	get_tree().get_current_scene().add_child(audioPlayer)
	audioPlayer.play()
	await audioPlayer.finished
	audioPlayer.queue_free()

func playMusic(musicName: String, forcePlay: bool = false) -> void:
	var music = ResourceLoader.load(musics[musicName]["path"])
	var musicVolume = musics[musicName]["volume"]
	
	if forcePlay == true:
		musicPlayer.set_stream(music)
		musicPlayer.play()
	else:
		if musicPlayer.is_playing() == false:
			musicPlayer.set_stream(music)
			musicPlayer.play()
			
			musicPlayer.set_volume_db(-30)
			var tween = get_tree().create_tween()
			tween.tween_property(musicPlayer, "volume_db", musicVolume, 2)

func addMusicToQueue(musicName) -> void:
	musicQueue.append(musicName)

func removeMusicFromQueue(musicName) -> void:
	musicQueue.erase(musicName)

func _on_music_player_finished():
	if musicQueue.size() > 0:
		var music = musicQueue.pop_front()
		playMusic(music)
	else:
		playMusic("menu")
