extends AcceptDialog
class_name GameOverUI
var next_scene = load("res://Scenes/ShopUI.tscn")
func ShowGameOver(playerCoins, levelCoins, wave, secondsPlayed):
	popup()
	dialog_text = "Collected coins: " + String(playerCoins)
	dialog_text += "\nCoins from level: " + String(levelCoins)
	dialog_text += "\nYou died on wave: " + String(wave)
	dialog_text += "\nSurvived for " + String(secondsPlayed) + " seconds"
	get_tree().paused = true

func _on_GameOver_confirmed():
	GameHandler._level = get_tree().get_nodes_in_group("PLAYER")[0].get_node("ExperienceSystem").level
	GameHandler.coins = get_tree().get_nodes_in_group("PLAYER")[0].coins
	get_tree().paused = false
	get_tree().change_scene_to(next_scene)
	#Change to main menu scene
