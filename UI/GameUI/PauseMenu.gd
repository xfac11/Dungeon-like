extends Panel
onready var statsLabel = $StatsPanel/VBoxContainer/StatsLabel
signal Pause(isPaused)
func onResumeClicked():
	visible = false
	emit_signal("Pause",false)
func onOptionsClicked():
	pass
func onQuitClicked():
	pass
