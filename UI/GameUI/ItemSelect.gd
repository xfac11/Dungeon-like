extends Panel
class_name ItemSelect
onready var buttons:Array = $HBoxContainer.get_children()
onready var player:Player = owner.get_tree().get_nodes_in_group("PLAYER")[0]
signal pause(pause)
func _ready() -> void:
	for button in buttons:
		button.connect("ItemPressed", self, "add_item_to_inventory")


func init_buttons(itemNames:Array) -> void:
	visible = true
	emit_signal("pause", true)
	for i in range(itemNames.size()):
		var item:Item = ItemDatabase.GetItem(itemNames[i])
		buttons[i].itemName = item.name
		buttons[i].itemNameLabel.text = item.name
		buttons[i].itemTexture.texture = item.texture
		buttons[i].itemDescription.text = item.description
		buttons[i].itemStatsLabel.text = _generate_stats_text(item)


func _generate_stats_text(item:Item):
	var statStr = ""
	if item.itemType == Item.ItemTypeResource.ItemType.WEAPON:
		statStr += "Damage: " + String(item.damage) + "\n"
	elif item.itemType == Item.ItemTypeResource.ItemType.PASSIVE:
		if item.health > 0 || item.health < 0:
			statStr += "Health: " + String(item.health) + "\n"
		if item.speed > 0 || item.speed < 0:
			statStr += "Speed: " + String(item.speed) + "\n"
		if item.armor > 0 || item.armor < 0:
			statStr += "Armor " + String(item.armor) + "\n"
	return statStr


func add_item_to_inventory(name:String) -> void:
	player.inventory.AddItem(name,1)
	visible = false
	emit_signal("pause", false)


