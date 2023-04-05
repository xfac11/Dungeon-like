extends Panel
class_name GameOverUI
var _next_scene = preload("../ShopUI/ShopUI.tscn")
func ShowGameOver(playerCoins, levelCoins, wave, secondsPlayed):
	visible = true
	$Collected/Coins.text = String(playerCoins)
	$LevelCoins/Coins.text = String(levelCoins)
	$Survived/Seconds.text = String(int(secondsPlayed)) + " seconds"
	get_tree().paused = true


func _on_Button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to(_next_scene)
	#Change to main menu scene
