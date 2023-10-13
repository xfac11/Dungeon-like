extends Panel
onready var optionMenu = $OptionMenu
onready var statsLabel:Label = $StatsPanel/VBoxContainer/HBoxContainer/StatsLabel
onready var statsNumber:Label = $StatsPanel/VBoxContainer/HBoxContainer/StatsNumber
signal Pause(isPaused)

func onResumeClicked():
	visible = false
	emit_signal("Pause",false)
func onOptionsClicked():
	pass
func onQuitClicked():
	pass
func _on_OptionsButton_pressed():
	optionMenu.visible = true
func reset():
	optionMenu.visible = false;
