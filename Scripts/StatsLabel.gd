extends Label


var stats:Stat
onready var player = owner.get_tree().get_nodes_in_group("PLAYER")[0]	
func _process(_delta):
	stats = player.currentStat
	if is_instance_valid(stats):
		text = stats.GetStatsAsJSON()
	
