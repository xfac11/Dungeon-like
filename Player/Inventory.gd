extends Resource
class_name Inventory
class ItemSlot:
	var item: Item
	var nrOfStacks: int

export var items = Array() setget SetItems, GetItems
signal inventoryChanged(items, itemName, quantity)
func Clear() -> void:
	items.clear()
func AddItem(itemName, quantity) -> void:
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
		itemInInventory.nrOfStacks = int(min(item.itemStat.maxStackSize, itemInInventory.nrOfStacks+quantity))
	else:
		var newItemSlot = ItemSlot.new()
		newItemSlot.nrOfStacks = 0
		newItemSlot.item = item
		newItemSlot.nrOfStacks = min(item.itemStat.maxStackSize, newItemSlot.nrOfStacks+quantity)
		items.append(newItemSlot)
	
	emit_signal("inventoryChanged",items, itemName, quantity)
	
func AddItems(itemsArray):
	for name in itemsArray:
		AddItem(name, 1)

func GetItems() -> Array:
	return items

func SetItems(newItems) -> void:
	items = newItems

func GetItem(index) -> ItemSlot:
	return items[index]

func GetItemByName(name:String) -> ItemSlot:
	var foundItem
	for item in items:
		if name == item.item.name:
			foundItem = item
			break
	return foundItem
