class_name GameScene
extends Node2D

export var seed_variable = 1337
onready var _game_over_menu = $UICanvasLayer/UI/GameOver
onready var _game_ui = $UICanvasLayer/UI

func _ready():
	get_tree().paused = false
	set_process(true)
	seed(seed_variable)


func _on_Health_healthDepleted(parent:Player):
	GameHandler._level = parent.experienceSystem.level
	GameHandler.coins = parent.coins
	_game_ui.visible_all(false)
	_game_over_menu.ShowGameOver(parent.coins,
			GameHandler.CoinsFromLevel(parent.experienceSystem.level),
			get_node("Spawner").wave, OS.get_ticks_msec()*0.001)
