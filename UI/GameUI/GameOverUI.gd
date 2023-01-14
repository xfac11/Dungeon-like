extends AcceptDialog
class_name GameOverUI
var _next_scene = preload("../ShopUI/ShopUI.tscn")
func ShowGameOver(playerCoins, levelCoins, wave, secondsPlayed):
	popup()
	dialog_text = "Collected coins: " + String(playerCoins)
	dialog_text += "\nCoins from level: " + String(levelCoins)
	dialog_text += "\nYou died on wave: " + String(wave)
	dialog_text += "\nSurvived for " + String(secondsPlayed) + " seconds"
	get_tree().paused = true

func _on_GameOver_confirmed():
	get_tree().paused = false
	get_tree().change_scene_to(_next_scene)
	#Change to main menu scene
