extends Node

onready var timer = $Timer
onready var high_beap = $HighClick  #AudioStreamPlayer 
onready var low_beap = $LowClick	#AudioStreamPlayer
onready var display = $Display 		#Label

export(int) var time_signature_top = 4
export(int) var time_signature_botton = 4
export(float) var  bpm  


var beat_interval
var current_beat
var current_measure

var currently_playing

func _ready():
	currently_playing = false
	current_beat = 0
	current_measure = -1
	
	beat_interval = 60 / bpm * 4 / float(time_signature_botton)
	timer.set_wait_time(beat_interval)
	display.set_text("0  0")



func _play_metronome():
	if current_beat % time_signature_top == 0:
		high_beap.play()
		current_beat = 1
		current_measure += 1
		display.set_text(str(current_measure) + "  " + str(current_beat))
		timer.start()
	else:
		low_beap.play()
		current_beat += 1
		display.set_text(str(current_measure) + "  " + str(current_beat))
		timer.start()

###use this function if you disconect the buttons
#func _stop_metronome():
#	currently_playing == false
#	display.set_text("0  0")

func _on_Timer_timeout():
	if currently_playing == true:
		_play_metronome()

func _on_StartButton_pressed():
	if currently_playing == false:
		currently_playing = true
		_play_metronome()


func _on_StopButton_pressed():
	if currently_playing == true:
		currently_playing = false
		current_beat = 0
		current_measure = -1
		display.set_text("0  0")
