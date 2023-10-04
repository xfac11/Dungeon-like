class_name ItemGiver
extends Node
# Used to generate items to the ItemSelect UI when the player level up

export var item_select_node_path:NodePath

var _item_select:ItemSelect

onready var player:Player = get_tree().get_nodes_in_group("PLAYER")[0]

func _ready() -> void:
	_item_select = get_node(item_select_node_path)
	player.get_node("ExperienceSystem").connect("gained_level", self, "show_items")


func show_items(_maxExp, _level) -> void:
	var random_items = Array()
	var itemsIndex = Array()
	for i in GameHandler.discoveredItems.size():
		var itemName = GameHandler.discoveredItems[i]
		var itemSlot= player.inventory.GetItemByName(itemName)
		var maxStacks = ItemDatabase.GetItem(itemName).itemStat.maxStackSize
		if itemSlot == null || itemSlot.nrOfStacks < maxStacks:
			itemsIndex.append(i)
	for i in 3:
		if itemsIndex.size() == 0:
			random_items.append("Coins")
		else:
			var random_index = randi()%itemsIndex.size()
			random_items.append(GameHandler.discoveredItems[itemsIndex[random_index]])
			itemsIndex.remove(random_index)
	_item_select.init_buttons(random_items)
