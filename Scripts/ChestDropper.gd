extends Node
class_name ChestDropper

signal spawn_coin(amount)
signal chest_items_added(items)
export(PackedScene) var chest_scene
# TODO: Static function?
func spawn_object(packedScene):
	var object = packedScene.instance()
	get_parent().add_child(object)
	object.transform = get_parent().transform
	return object

# TODO: Static function?
func dice_roll(chance):
	if chance <= 0 || chance >= 1:
		return bool(chance)
	return randf() < chance


func spawn_chest(position):
	var chest:Chest = spawn_object(chest_scene)
	chest.position = position
	var _u = chest.connect("ChestPickedUp",self,"roll_chest_user_interface")


func roll_chest_user_interface(chest):
	var count = get_item_count()
	var player:Player = get_tree().get_nodes_in_group("PLAYER")[0]
	var possibleItems = create_possible_items(player.inventory)
	##No items to give then spawn a coin for the player to pick up
	if possibleItems.size() == 0:
		emit_signal("spawn_coin", 3)
		return
	var itemsToAdd = random_items_from_inventory(count, possibleItems)
	player.inventory.AddItems(itemsToAdd)
	show_chest_user_interface(itemsToAdd, possibleItems)


func get_item_count():
	var count = 1
	if dice_roll(0.3):
		count = 3
	if dice_roll(0.1):
		count = 5
	return count


func create_possible_items(inventory):
	var itemsInInventory = inventory.GetItems()
	var possibleItems = Array()
	for item in itemsInInventory:
		var inventoryItemStack = item.nrOfStacks
		var actualItem:Item = item.item
		if actualItem.maxStackSize > inventoryItemStack:
			possibleItems.append(item)
	return possibleItems


func show_chest_user_interface(itemsToAdd, _possibleItems):
	emit_signal("chest_items_added", itemsToAdd)


func random_items_from_inventory(count:int, items:Array):
	var itemsInInventory = items
	var numberOfItems = items.size()
	if numberOfItems == 0:
		return
	var itemsToAdd = Array()
	for i in count:
		var randomIndex = randi() % numberOfItems
		var itemName = itemsInInventory[randomIndex].item.name
		itemsToAdd.append(itemName)
	return itemsToAdd


func _on_Special_spawn_chest(position):
	call_deferred("spawn_chest", position)
