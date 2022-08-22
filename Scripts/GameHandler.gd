extends Node


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
	

