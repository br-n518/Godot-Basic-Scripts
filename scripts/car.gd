extends VehicleBody


export(float) var DRIVE_FORCE = 50.0
export(float) var BRAKE_FORCE = 35.0
export(float) var TURN_FORCE = 2.0

# warning-ignore:unused_argument
func _process(delta):
	var b_drive = Input.is_action_pressed("drive")
	var b_brake = Input.is_action_pressed("brake")
	var b_steer_left = Input.is_action_pressed("steer_left")
	var b_steer_right = Input.is_action_pressed("steer_right")
	
	if b_drive:
		engine_force = DRIVE_FORCE
	else:
		engine_force = 0.0
	
	if b_brake:
		brake = BRAKE_FORCE
	else:
		brake = 0.0
	
	if b_steer_left and not b_steer_right:
		steering = -TURN_FORCE
	elif b_steer_right and not b_steer_left:
		steering = TURN_FORCE
	else:
		steering = 0.0