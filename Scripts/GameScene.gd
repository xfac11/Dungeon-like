extends Node2D

var maximumEnemies = 25
export var mSeedVariable = 12345
onready var pauseMenu = $UICanvasLayer/UI/PauseMenu
onready var gameOverMenu:GameOverUI = $UICanvasLayer/UI/GameOver
var pauses = 0
func _ready():
	get_tree().paused = false
	set_process(true)
	PlayerInit(get_tree().get_nodes_in_group("PLAYER")[0])
	seed(mSeedVariable)

func InreaseEnemiesAmount(level) -> float:
	return 10 + (1.25*level)

func PlayerInit(player:Player):
	player.experienceSystem.connect("leveledup",self,"IncreaseEnemies")

func IncreaseEnemies(_maxExp,level):
	maximumEnemies+= InreaseEnemiesAmount(level)


	


func _on_Health_healthDepleted(parent):
	gameOverMenu.ShowGameOver(parent.coins,
	GameHandler.CoinsFromLevel(parent.get_node("ExperienceSystem").level),
	get_node("Spawner").wave,OS.get_ticks_msec()*0.001)
