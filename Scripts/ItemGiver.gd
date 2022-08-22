extends Node
var itemSelect
func _ready():
	var _unused = GameHandler.connect("playerInitialized",self,"Init")
func Init(player):
	var expSystem = player.get_node("ExperienceSystem")
	expSystem.connect("leveledup",self,"ShowItems")
	itemSelect = get_node("/root/GameScene/UICanvasLayer/UI/ItemSelect")

func ShowItems(_maxExp, _lelve):
	var randomItems = Array()
	for i in 3:
		randomItems.append(ItemDatabase.GetRandomItem().name)
	itemSelect.InitButtons(randomItems)
