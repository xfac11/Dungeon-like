extends Control
onready var pauseMenu = $PauseMenu
var pauses = 0
var next_scene = load("res://Scenes/MainMenuUI.tscn")
func _input(event):
	if event.is_action_pressed("exit_game"):
		pauseMenu.visible = !pauseMenu.visible
		Pause(pauseMenu.visible)
func Pause(pause):
	if pause:
		pauses+= 1
	else:
		pauses-= 1
	if pauses >= 1:
		get_tree().paused = true
	elif pauses == 0:
		get_tree().paused = false


func _on_ItemSelect_Pause(pause):
	Pause(pause)


func _on_PauseMenu_Pause(isPaused):
	Pause(isPaused)


func _on_QuitButton_pressed():
	get_tree().change_scene_to(next_scene)


func _on_ChestUI_Pause(isPause):
	Pause(isPause)


func _on_ChestDropper_chest_items_added(items):
	$ChestUI.SetItems(items)
	$ChestUI.visible = true
	Pause(true)
