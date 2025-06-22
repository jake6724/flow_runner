class_name Run
extends State

func init_state():
	animation_1 = "run"

func enter_state():
	player.jump_count = 0

func process_state(_delta):
	#player.velocity.x = 50
	player.ap.play(animation_1)

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("jump"):
			transition_state.emit(self, "jump")
		
		elif Input.is_action_pressed("slide"):
			transition_state.emit(self, "slide")