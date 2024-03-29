extends Control
onready var pauseMenu = $PauseMenu
onready var healthBar = $HPbar
var pauses = 0
var next_scene = preload("../MainMenu/MainMenuUI.tscn")
func _input(event):
	if event.is_action_pressed("exit_game"):
		pauseMenu.reset()
		pauseMenu.visible = !pauseMenu.visible
		_generate_stats_text(get_tree().get_nodes_in_group("PLAYER")[0])
		Pause(pauseMenu.visible)


func _generate_stats_text(player:Player):
	var statsDict = player.currentStat.get_stat_as_dictionary()
	var statLabelStr = ""
	var statLabelNumber = ""
	for stat in statsDict:
		if stat == "Crit chance" || stat == "Dodge chance":
			statLabelNumber += String(statsDict[stat]*100) + "%\n"
		else:
			statLabelNumber += String(statsDict[stat]) + "\n"
		statLabelStr += stat + "\n"
		
	
	pauseMenu.statsLabel.text = statLabelStr
	pauseMenu.statsNumber.text = statLabelNumber 
	


func visible_all(isVisible):
	healthBar.visible = isVisible
	$LevelNumber.visible = isVisible
	$Panel.visible = isVisible
	$CoinDisplay.visible = isVisible


func Pause(pause):
	if pause:
		pauses+= 1
	else:
		pauses-= 1
	if pauses >= 1:
		get_tree().paused = true
	elif pauses == 0:
		get_tree().paused = false


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


func _on_ItemSelect_pause(pause):
	Pause(pause)


func _set_health_UI(currentHealth, maximumHealth, changeAmount):
	healthBar.update_health_UI(maximumHealth, currentHealth)


func _on_Health_healthSet(currentHealth, maximumHealth):
	healthBar.update_health_UI(maximumHealth, currentHealth)


func _on_Health_healed(currentHealth, maximumHealth, healedAmount):
	healthBar.update_health_UI(maximumHealth, currentHealth)


func _on_Health_damageTaken(currentHealth, maximumHealth, damageAmount):
	healthBar.update_health_UI(maximumHealth, currentHealth)


func _on_Health_healthDepleted(parent):
	pass # Replace with function body.


func _on_Player_coin_picked(coins):
	$CoinDisplay/HBoxContainer/Coins.text = str(coins)
