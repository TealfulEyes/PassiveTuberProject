extends Node2D

var micDetection
export var canBlink = true
## ADD, CHANGE, OR REMOVE NUMBERS FROM THE BACKET HERE FOR RANDOMIZED BLINK TIMES ##
var blinktime = [2,1,5,10,4]

func _ready():
	## REMOVE "#" FROM THE BELOW LINE TO PRINT THE AUDIO CAPTURE DEVICE. IT SHOULD READ AS DEFAULT ##
	# print("YOUR AUDIO CAPTURE DEVICE IS ", AudioServer.capture_get_device()) # This will print what the capture device is that's recording
	randomize()
	
func _process(_delta):
	micDetection = abs(AudioServer.get_bus_peak_volume_left_db(AudioServer.get_bus_index("Mic"),0))
	# SET THE NUMBERS BELOW TO BE THE SAME. REMOVE "#" FRIN LINE 21 TO PRINT IN REALTIME WHAT YOUR MIC IS DETECTING, IF IT SHOWS AS 200, THERE IS NO SOUND BEING DETECTED
	if micDetection < 30: 
		$character.play("talk")
	elif micDetection > 30:
		$character.play("idle")
	## PRINTS THE REAL TIME MICROPHONE VOLUME (THIS CAN HELP WITH SENSITIVITY WHEN TALKING SHOULD AND SHOULDNT TRIGGER) ##
	# print("Current Volume is ", micDetection)
	## BLINK TIMER - REMOVE "#" FROM LINE BELOW TO SEE WHAT THE TIME IS SET TO ##
	# print($Timer.wait_time)

func _on_Timer_timeout():
	$eyes.play("blinking")

func _on_eyes_animation_finished():
	$eyes.stop()
	$Timer.wait_time = blinktime[randi() % blinktime.size()]
	$Timer.start()
