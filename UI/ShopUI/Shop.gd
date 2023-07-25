class_name Shop
extends Node

export var discover_item_cost_increase:int = 250
export(PackedScene) var shop_slot_button:PackedScene
export var discover_item_cost:int = 100
var _next_scene = load("res://Scenes/GameScene.tscn")
var _main_menu_scene = load("res://UI/MainMenu/MainMenuUI.tscn")
var _coin:int = 200

onready var _coins_UI:ShopCoinUI = $Coins
onready var _shop_tab:TabContainer = $ShopTabContainer
onready var _discover_item_button:Button = $DiscoverItemButton


func _ready() -> void:
	_coin = SaveLoad.data.coins
	GameHandler.discoveredItems = SaveLoad.data.discoveredItems
	var newDiscoverCost = GameHandler.discoveredItems.size() - GameHandler.defaultDiscoveredSize
	if newDiscoverCost > 0:
		discover_item_cost += discover_item_cost_increase * newDiscoverCost
	
	_coins_UI.ChangeCoins(_coin)
	_add_tab("Sword")
	_add_tab("Player")
	_update_slots("Sword")
	_update_slots("Player")
	_discover_item_button.connect("pressed", self, "_on_discover_item_pressed")
	_discover_item_button.get_node("Label").text = str(discover_item_cost)
	_update_discover_item()


func _pressed_add_upgrade(cost,slot:ShopSlotButton) -> void:
	if cost <= _coin && slot.stack < slot.maxStack:
		slot.AddToStack()
		_update_coins(cost)


func _on_discover_item_pressed() -> void:
	if discover_item_cost <= _coin:
		_update_coins(discover_item_cost)
		var newItem = GameHandler.AddDiscoveredItem()
		if !is_instance_valid(newItem):
			return
		discover_item_cost += discover_item_cost_increase
		_update_discover_item()
		##Show the new item with some particles and animations


func _update_coins(cost) -> void:
	_coin -= cost
	_coins_UI.ChangeCoins(_coin)
	_update_slots("Sword")
	_update_slots("Player")
	_update_discover_item()


func _update_discover_item() -> void:
	_discover_item_button.get_node("Label").text = str(discover_item_cost)
	if !GameHandler.IsDiscoverableItems():
		_discover_item_button.get_node("Label").text = "Found all"
	if discover_item_cost > _coin || !GameHandler.IsDiscoverableItems():
		_discover_item_button.disabled = true
	else:
		_discover_item_button.disabled = false


func _update_slots(var name:String) -> void:
	var swordButtons = _shop_tab.get_node(name + "/GridContainer").get_children()
	for button in swordButtons:
		var slotCost = int(button.costLabel.text)
		if slotCost > _coin:
			button.disabled = true
		else:
			button.disabled = false


func _add_tab(var name:String) -> void:
	var swordTabContainer = _shop_tab.get_node(name + "/GridContainer")
	var swordShopSlots = Array()
	var directory = Directory.new()
	directory.open("res://ShopSlots/"+name)
	directory.list_dir_begin()
	
	var filename = directory.get_next()
	while filename:
		if not directory.current_is_dir():
			swordShopSlots.append(load("res://ShopSlots/"+name+"/%s" % filename))
			
		filename = directory.get_next()
	for slot in swordShopSlots:
		var newButton:ShopSlotButton = shop_slot_button.instance()
		swordTabContainer.add_child(newButton)
		newButton.SetCostText(slot.cost)
		newButton.SetDescription(slot.description)
		newButton.SetMaxStack(slot.numberOfStacks)
		newButton.texture.texture = slot.texture
		newButton.costIncrease = slot.costIncrease
		newButton.connect("TestBuy", self, "_pressed_add_upgrade")
		newButton.shopSlot = slot
		if SaveLoad.file_exists():
			if SaveLoad.data.stacks.has(newButton.shopSlot.resource_path):
				for i in SaveLoad.data.stacks[newButton.shopSlot.resource_path]:
					newButton.AddToStack()


func _start_game() -> void:
	_set_player_shop_stat()
	_set_sword_shop_stat()
	SaveLoad.data.coins = _coin
	SaveLoad.data.discoveredItems = GameHandler.discoveredItems
	SaveLoad.saveJSON()
	_start_game_scene()


func _set_player_shop_stat() -> void:
	var stat:Stat = Stat.new()
	for slot in _shop_tab.get_node("Player"+"/GridContainer").get_children():
		var shopSlotUI:ShopSlotButton = slot
		stat.AddStat(shopSlotUI.shopSlot.stat, shopSlotUI.stack)
		SaveLoad.data.stacks[shopSlotUI.shopSlot.resource_path] = shopSlotUI.stack
	GameHandler.shopPlayerStat = stat


func _set_sword_shop_stat() -> void:
	var stat:Stat = Stat.new()
	for slot in _shop_tab.get_node("Sword"+"/GridContainer").get_children():
		var shopSlotUI:ShopSlotButton = slot
		var shopSlotStat:Stat = shopSlotUI.shopSlot.stat
		SaveLoad.data.stacks[shopSlotUI.shopSlot.resource_path] = shopSlotUI.stack
		if !is_instance_valid(shopSlotStat):
			continue
		stat.AddStat(shopSlotStat, shopSlotUI.stack)
	GameHandler.shopSwordStat = stat


func _start_game_scene() -> void:
	get_tree().change_scene_to(_next_scene)


func _on_Button_pressed() -> void:
	_start_game()

func _start_main_menu():
	_set_player_shop_stat() ## Sets the stacks in SaveLoad.data
	_set_sword_shop_stat() ## Sets the stacks in SaveLoad.data
	SaveLoad.data.coins = _coin
	SaveLoad.data.discoveredItems = GameHandler.discoveredItems
	SaveLoad.saveJSON()
	get_tree().change_scene_to(_main_menu_scene)


func _on_MainMenu_pressed():
	_start_main_menu()
