extends WindowDialog

# Scene Layout
### WindowDialog (OptionsDialog)
### 	GridContainer (Grid): columns = 2; vsep = 16; hsep = 10;
### 		Label (Label): "Mouse Sensitivity"
### 		HSlider (MouseSlider) [1, 10]
### 		Label (Label2): "Gamepad Sensitivity"
### 		HSlider (GamepadSlider) [1, 10]
### 		Label (Label3): "Invert Gamepad Y"
### 		CheckBox (InvertYButton)

# Configure focus neighbors between 3 controls.
# Closing the dialog box applies values to globals
# Sliders should have rounded values, so user can only choose integers.

func _ready():
	$Grid/MouseSlider.value = _globals.MOUSE_SENS_LEVEL
	$Grid/GamepadSlider.value = _globals.GAMEPAD_SENS_LEVEL
	$Grid/InvertYButton.pressed = _globals.INVERT_Y
	connect("popup_hide", self, "commit_options")

# connect options Button signal "pressed" to show_options (scene must be in tree)
func show_options():
	show_modal()
	$Grid/MouseSlider.grab_focus()

func commit_options():
	_globals.MOUSE_SENS_LEVEL = int($Grid/MouseSlider.value)
	_globals.GAMEPAD_SENS_LEVEL = int($Grid/GamepadSlider.value)
	_globals.INVERT_Y = $Grid/InvertYButton.pressed
