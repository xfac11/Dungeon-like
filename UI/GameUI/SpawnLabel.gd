extends Label
export var waveTimer:NodePath
onready var waveText = $Label
func OnTick(seconds):
	text = String(int(seconds))
func OnNewWave(waveNumber):
	waveText.text = String(waveNumber)
func _process(delta):
	OnTick(get_node(waveTimer).time_left)


func _on_Spawner_NewWave(waveNumber):
	OnNewWave(waveNumber)
