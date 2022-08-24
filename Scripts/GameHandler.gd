extends Node

#TODO MOVE MAXENEMIES TO GAMESCENE

var maximumEnemies = 25
var player
signal playerInitialized(player)
func _process(_delta):
	if not player:
		InitPlayer()
		return
	
func InitPlayer():
	player = get_node("/root/GameScene/Player")
	if not player:
		return
	emit_signal("playerInitialized", player)
	player.get_node("ExperienceSystem").connect("leveledup",self,"IncreaseEnemies")
	

func IncreaseEnemies(_maxExp,_level):
	maximumEnemies+= 10
