extends ColorRect
class_name ItemSelect
onready var buttons:Array = $CenterContainer/HBoxContainer.get_children()
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
		buttons[i].itemTexture.texture = item.texture
		buttons[i].hint_tooltip = item.description


func add_item_to_inventory(name:String) -> void:
	player.inventory.AddItem(name,1)
	visible = false
	emit_signal("pause", false)


