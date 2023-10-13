extends Panel
class_name ItemSelect
onready var buttons:Array = $HBoxContainer.get_children()
var player
var coin_texture = preload("res://Looting/Coin.tres")
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
		else:
			var item:Item = ItemDatabase.GetItem(itemNames[i])
			_item_button(i, item)


func _item_button(index, item:Item):
	buttons[index].itemName = item.name
	buttons[index].itemNameLabel.text = item.name
	buttons[index].itemTexture.texture = item.texture
	buttons[index].itemDescription.text = item.description
	buttons[index].itemStatsLabel.text = _generate_stats_text(item)


func _coin_button(index):
	buttons[index].itemName = "Coins"
	buttons[index].itemNameLabel.text = "Coins"
	buttons[index].itemTexture.texture = coin_texture
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
	if name != "":
		if name == "Coins":
			player.GiveCoin(10)
		else:
			player.inventory.AddItem(name,1)
		visible = false
		emit_signal("pause", false)


func set_player(a_player:Player):
	player = a_player
