extends Label


var stats
func _ready():
	var _unused = GameHandler.connect("playerInitialized",self,"ConnectStats")
	
func ConnectStats(player):
	stats = player.currentStat

func _process(_delta):
	text = stats.GetStatStr()
	
