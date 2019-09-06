extends Node

onready var MOUSE_SENS_LEVEL:int = 1
onready var GAMEPAD_SENS_LEVEL:int = 5
onready var GAMEPAD_INVERT_Y:bool = false

func _input(event):
	if event is InputEventKey and event.is_pressed():
		match event.scancode:
			KEY_ESCAPE:
				Input.set_mouse_mode( Input.MOUSE_MODE_VISIBLE )
			KEY_F11:
				OS.set_window_fullscreen( not OS.window_fullscreen )
				get_viewport().size = OS.window_size



