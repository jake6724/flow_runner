class_name Jump
extends State

func init_state():
	animation_1 = "jump"
	animation_2 = "double_jump"
	player.ap.animation_finished.connect(on_animation_finished)

func enter_state():
	jump()

func jump():
	if player.jump_count < player.jump_max:
		if player.jump_count == 0: player.ap.play(animation_1) 
		else: player.ap.play(animation_2)

		player.velocity.y = -player.jump_power
		player.jump_count += 1
		# player.jump_power /= 2
		player.jump_in_progress = false

func process_state(_delta):
	if player.is_on_floor():
		transition_state.emit(self, "run")

func on_animation_finished(anim_name):
	if anim_name == animation_1 or anim_name == animation_2:
		transition_state.emit(self, "fall")	
