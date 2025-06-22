class_name Slide
extends State

func init_state():
	animation_1 = "slide"

func enter_state():
	player.jump_count = 0

func process_state(_delta):
	player.ap.play(animation_1)

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("jump"):
			transition_state.emit(self, "jump")

		elif Input.is_action_just_released("slide"):
			transition_state.emit(self, "run")