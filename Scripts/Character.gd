extends Node2D

var micDetection
export var canBlink = true
var blinktime = [2,1,5,10,4]

func _ready():
	print("YOUR AUDIO CAPTURE DEVICE IS ", AudioServer.capture_get_device()) # This will print what the capture device is that's recording
	randomize()
	
func _process(_delta):
	micDetection = abs(AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Mic"),0))
	if micDetection < 30: #Muted volume is 200(-200 without abs) and will decrease depending on mic. Adjust number values to best fit your setup
		$character.play("talk")
	elif micDetection > 30:
		$character.play("idle")
	# FOR OUTPUT TO MAKE SURE CHANGES ARE HAPPENING AS THEY SHOULD
	## MICROPHONE VOLUME (THIS CAN HELP WITH SENSITIVITY WHEN TALKING SHOULD AND SHOULDNT TRIGGER) ##
	# print("Current Volume is ", micDetection)
	## BLINK TIMER - REMOVE "#" FROM LINE BELOW TO SEE WHAT THE TIME IS SET TO ##
	# print($Timer.wait_time)


func _on_Timer_timeout():
	$eyes.play("blinking")

func _on_eyes_animation_finished():
	$eyes.stop()
	$Timer.wait_time = blinktime[randi() % blinktime.size()]
	$Timer.start()
