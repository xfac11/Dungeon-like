class_name ItemGiver
extends Node
# Used to generate items to the ItemSelect UI when the player level up

export var item_select_node_path:NodePath

var _item_select:ItemSelect

onready var player:Player = get_tree().get_nodes_in_group("PLAYER")[0]

func _ready() -> void:
	_item_select = get_node(item_select_node_path)
	player.get_node("ExperienceSystem").connect("leveledup", self, "show_items")


func show_items(_maxExp, _level) -> void:
	var random_items = Array()
	for i in 3:
		var random_index = randi()%GameHandler.discoveredItems.size()
		random_items.append(GameHandler.discoveredItems[random_index])
	_item_select.init_buttons(random_items)
