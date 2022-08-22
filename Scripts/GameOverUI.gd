extends AcceptDialog

func ShowGameOver():
	popup()
	get_tree().paused = true

func _on_Health_healthDepleted():
	ShowGameOver()


func _on_GameOver_confirmed():
	get_tree().paused = false
	#Change to main menu scene
