extends Panel
class_name ItemSelect
onready var buttons:Array = $HBoxContainer.get_children()
onready var player:Player = owner.get_tree().get_nodes_in_group("PLAYER")[0]
var coinTexture = preload("res://Looting/Coin.tres")
signal pause(pause)
func _ready() -> void:
	for button in buttons:
		button.connect("ItemPressed", self, "add_item_to_inventory")


func init_buttons(itemNames:Array) -> void:
	visible = true
	emit_signal("pause", true)
	for i in range(itemNames.size()):
		if itemNames[i] == "Coins":
			_coin_button(i)
			continue
		var item:Item = ItemDatabase.GetItem(itemNames[i])
		buttons[i].itemName = item.name
		buttons[i].itemNameLabel.text = item.name
		buttons[i].itemTexture.texture = item.texture
		buttons[i].itemDescription.text = item.description
		buttons[i].itemStatsLabel.text = _generate_stats_text(item)


func _coin_button(index):
	buttons[index].itemName = "Coins"
	buttons[index].itemNameLabel.text = "Coins"
	buttons[index].itemTexture.texture = coinTexture
	buttons[index].itemDescription.text = "Recieve some coins"
	buttons[index].itemStatsLabel.text = "Value: 10"


func _generate_stats_text(item:Item):
	var statStr = ""
	if item.itemType == ItemStat.ItemTypeResource.ItemType.WEAPON:
		statStr += "Damage: " + String(item.damage) + "\n"
	elif item.itemType == ItemStat.ItemTypeResource.ItemType.PASSIVE:
		if item.health > 0 || item.health < 0:
			statStr += "Health: " + String(item.health) + "\n"
		if item.speed > 0 || item.speed < 0:
			statStr += "Speed: " + String(item.speed) + "\n"
		if item.armor > 0 || item.armor < 0:
			statStr += "Armor " + String(item.armor) + "\n"
	return statStr


func add_item_to_inventory(name:String) -> void:
	if name == "Coins":
		player.GiveCoin(10)
	else:
		player.inventory.AddItem(name,1)
	visible = false
	emit_signal("pause", false)


