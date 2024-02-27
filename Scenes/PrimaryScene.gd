extends Node
var Hidden = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _toggle():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Hidden == true && Input.is_key_pressed(KEY_T):
		Hidden = false
		print("HIDDEN IS SET TO FALSE")
		
	if Hidden == false && Input.is_key_pressed(KEY_T):
		Hidden = true
		print("HIDDEN IS SET TO TRUE")
		
	if Hidden:
		$Character/Controller.visible = true
	else:
		$Character/Controller.visible = false
		
