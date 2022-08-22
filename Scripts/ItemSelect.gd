extends HBoxContainer

onready var buttons = get_children()
func _ready():
	for button in buttons:
		button.connect("ItemPressed", self, "AddItemToInventory")
func InitButtons(itemNames:Array):
	visible = true
	get_tree().paused = true
	for i in range(itemNames.size()):
		var item = ItemDatabase.GetItem(itemNames[i])
		buttons[i].itemName = item.name
		buttons[i].itemTexture.texture = item.texture
		

func AddItemToInventory(name):
	GameHandler.player.inventory.AddItem(name,1)
	visible = false
	get_tree().paused = false


