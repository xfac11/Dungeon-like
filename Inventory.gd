extends Resource
class_name Inventory
class ItemSlot:
	var item: Item
	var nrOfStacks: int

export var items = Array() setget SetItems, GetItems
signal inventoryChanged(items, itemName, quantity)
func AddItem(itemName, quantity):
	var item = ItemDatabase.GetItem(itemName)
	if item == null:
		return
	var exists = false
	var itemInInventory:ItemSlot
	for i in items:
		if i.item.name == itemName:
			exists = true
			itemInInventory = i
			break
		
	if exists:
		itemInInventory.nrOfStacks = int(min(item.maxStackSize, itemInInventory.nrOfStacks+quantity))
	else:
		var newItemSlot = ItemSlot.new()
		newItemSlot.nrOfStacks = 0
		newItemSlot.item = item
		newItemSlot.nrOfStacks = min(item.maxStackSize, newItemSlot.nrOfStacks+quantity)
		items.append(newItemSlot)
	
	emit_signal("inventoryChanged",items, itemName, quantity)
	
	
func GetItems():
	return items

func SetItems(newItems):
	items = newItems

func GetItem(index):
	return items[index]

