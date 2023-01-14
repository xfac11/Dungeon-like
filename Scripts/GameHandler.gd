extends Node
var discoveredItems:Array = ["Red Ring", "Knife", "Shotgun"]
var defaultDiscoveredSize = discoveredItems.size()
var player
var shopPlayerStat:Stat = Stat.new()
var shopSwordStat:Stat = Stat.new()
var _level = 0
var coins = 0
func AddDiscoveredItem() -> Item:
	var newItem:Item = GetRandomHidenItem()
	discoveredItems.append(newItem.name)
	return newItem


func IsDiscoverableItems() -> bool:
	var hidenItems = GetNonDiscoveredItemsIndices()
	if hidenItems.size() == 0:
		return false
	return true


func GetNonDiscoveredItemsIndices() -> Array:
	var itemIndexArray = Array()
	var index = 0
	for item in ItemDatabase.items:
		var found = false
		for discoveredItem in discoveredItems:
			if item.name == discoveredItem:
				found = true
		if !found:
			itemIndexArray.append(index)
		index += 1
	return itemIndexArray


func GetRandomHidenItem() -> Item:
	var items = ItemDatabase.items
	var itemIndexArray = GetNonDiscoveredItemsIndices()
	if itemIndexArray.size() == 0:
		return null
	var newItemIndex:int = randi()%itemIndexArray.size()
	return items[itemIndexArray[newItemIndex]]


func CoinsFromLevel(level):
	return (level - 1) * 25


func calculate_coins() -> int:
	return CoinsFromLevel(_level) + coins
