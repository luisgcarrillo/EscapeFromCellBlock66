extends Node


@onready var audio_stream_player = $AudioPlayers/AudioStreamPlayer
@onready var audio_players = $AudioPlayers

const HURT = preload("res://Sounds/death_sound_2.wav")
const JUMP = preload("res://Sounds/jump_real.wav")
const DBL_JUMP = preload("res://Sounds/dbl_jump_real.wav")
const STAR = preload("res://Sounds/star_pickup.wav")
const BOUNCE = preload("res://Sounds/jump_1.wav")
const SHOT1 = preload("res://Sounds/cannon_1.wav")
const SHOT2 = preload("res://Sounds/cannon_2.wav")

func play_sound(sound):
	for audioStreamPlayer in audio_players.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break

