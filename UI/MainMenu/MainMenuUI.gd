extends Control

var next_scene = load("res://Scenes/GameScene.tscn")
onready var options = $OptionMenu
func _ready():
	get_tree().paused = false

func StartGame():
	get_tree().change_scene_to(next_scene)

func QuitGame():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().quit() # default behavior

func _on_PlayButton_pressed():
	StartGame()

func _on_QuitButton_pressed():
	QuitGame()

func _on_OptionButton_pressed():
	DisplayOptions()
func DisplayOptions():
	options.visible = true
