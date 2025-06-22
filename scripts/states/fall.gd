class_name Fall
extends State

func init_state():
	animation_1 = "fall"

func process_state(_delta):
	player.ap.play(animation_1)

	if player.is_on_floor():
		if Input.is_action_pressed("slide"):
			transition_state.emit(self, "slide")
		else:
			transition_state.emit(self, "run")

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("jump"):
			transition_state.emit(self, "jump")