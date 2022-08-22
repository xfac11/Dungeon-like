extends NinePatchRect

onready var container = $HBoxContainer
export(PackedScene) var itemDisplay:PackedScene

func _ready():
	
	var _unused = GameHandler.connect("playerInitialized", self, "ConnectInventory")

func ConnectInventory(player):
	player.inventory.connect("inventoryChanged", self, "UpdateInventoryUI")

func UpdateInventoryUI(items, _newItemName, _quantity):
	for i in items:
		var exists = false
		for disp in container.get_children():
			if i.item.name == disp.itemName:
				disp.UpdateItem(i.item,i.nrOfStacks)
				exists = true
		if not exists:
			var newItemDisplay = itemDisplay.instance()
			container.add_child(newItemDisplay)
			newItemDisplay.UpdateItem(i.item,i.nrOfStacks)
			
	
