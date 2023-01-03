extends Node
var itemSelect:ItemSelect
func _ready() -> void:
	Init()
func Init() -> void:
	var expSystem:ExperienceSystem = get_tree().get_nodes_in_group("PLAYER")[0].get_node("ExperienceSystem")
	expSystem.connect("leveledup",self,"ShowItems")
	itemSelect = get_node("/root/GameScene/UICanvasLayer/UI/ItemSelect")

func ShowItems(_maxExp, _level) -> void:
	var randomItems = Array()
	for i in 3:
		var randomIndex = randi()%GameHandler.discoveredItems.size()
		randomItems.append(GameHandler.discoveredItems[randomIndex])
	itemSelect.InitButtons(randomItems)
