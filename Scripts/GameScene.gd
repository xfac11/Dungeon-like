class_name GameScene
extends Node2D

export var seed_variable = 1337
onready var _game_over_menu = $UICanvasLayer/UI/GameOver
onready var _game_ui = $UICanvasLayer/UI
onready var player = $Player
func _ready():
	get_tree().paused = false
	set_process(true)
	seed(seed_variable)
	randomize()
	
	if SaveLoad.data.discoveredItems.size() == 0:
		SaveLoad.data.discoveredItems = GameHandler.discoveredItems
	
	
	connect_health_ui(get_node("Player/Health"), get_node("UICanvasLayer/UI/HPbar"))


func _on_Health_healthDepleted(parent:Player):
	GameHandler._level = parent.experienceSystem.level
	GameHandler.coins = parent.coins
	SaveLoad.data.coins += GameHandler.calculate_coins()
	_game_ui.visible_all(false)
	_game_over_menu.ShowGameOver(parent.coins,
			GameHandler.CoinsFromLevel(parent.experienceSystem.level),
			get_node("Spawner").wave, OS.get_ticks_msec()*0.001)


func connect_health_ui(health:Health, healthBar:HealthBar) -> void:
	health.connect("damageTaken", healthBar, "update_health_UI")
	health.connect("healed", healthBar, "update_health_UI")
	health.connect("healthSet", healthBar, "update_health_UI")
