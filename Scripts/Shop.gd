extends Node
class_name Shop

onready var coinsUI:ShopCoinUI = $Coins
onready var shopTab:TabContainer = $ShopTabContainer
onready var discoverItemButton:Button = $DiscoverItemButton
var next_scene = preload("res://Scenes/GameScene.tscn")
export(PackedScene) var shopSlotButton:PackedScene
var coin:int = 200
export var discoverItemCost:int = 100
export var discoverItemCostIncrease:int = 250
var saveStatsResource = preload("res://SaveStats.gd")
var saveStat = saveStatsResource.new()
var saveName = "res://Saves/new_save1.tres"
func _ready() -> void:
	var defaultDiscoveredSize = GameHandler.defaultDiscoveredSize
	if ResourceLoader.exists(saveName):
		saveStat = ResourceLoader.load(saveName)
		coin = saveStat.coins
		if saveStat.discoveredItems.size() > 0:
			GameHandler.discoveredItems = saveStat.discoveredItems
	coin+=GameHandler.CoinsFromLevel(GameHandler.level) + GameHandler.coins
	var newDiscoverCost = GameHandler.discoveredItems.size()
	newDiscoverCost-= defaultDiscoveredSize
	if newDiscoverCost > 0:
		discoverItemCost+=discoverItemCostIncrease*newDiscoverCost
	coinsUI.ChangeCoins(coin)
	AddTab("Sword")
	AddTab("Player")
	##AddTab("Items")
	UpdateSlots("Sword")
	UpdateSlots("Player")
	##UpdateSlots("Items")
	discoverItemButton.connect("pressed",self,"AddNewItem")
	discoverItemButton.get_node("Label").text = str(discoverItemCost)
	saveStat.coins = coin
	ResourceSaver.save(saveName,saveStat)
func AddUpgrade(cost,slot:ShopSlotButton) -> void:
	if cost <= coin && slot.stack < slot.maxStack:
		slot.AddToStack()
		UpdateCoins(cost)

func AddNewItem() -> void:
	if discoverItemCost <= coin:
		UpdateCoins(discoverItemCost)
		var newItem = GameHandler.AddDiscoveredItem()
		discoverItemCost += discoverItemCostIncrease
		UpdateDiscoverItem()
		##Show the new item with some particles and animations
		

func UpdateCoins(cost) -> void:
	coin-=cost
	coinsUI.ChangeCoins(coin)
	UpdateSlots("Sword")
	UpdateSlots("Player")
	UpdateSlots("Items")
	UpdateDiscoverItem()
	
func UpdateDiscoverItem() -> void:
	discoverItemButton.get_node("Label").text = str(discoverItemCost)
	if discoverItemCost > coin:
		discoverItemButton.disabled = true
	else:
		discoverItemButton.disabled = false
func UpdateSlots(var name:String) -> void:
	var swordButtons = shopTab.get_node(name+"/GridContainer").get_children()
	for button in swordButtons:
		var slotCost = int(button.costLabel.text)
		if slotCost > coin:
			button.disabled = true
		else:
			button.disabled = false
	
func AddTab(var name:String) -> void:
	var swordTabContainer = shopTab.get_node(name+"/GridContainer")
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
		var newButton:ShopSlotButton = shopSlotButton.instance()
		swordTabContainer.add_child(newButton)
		newButton.SetCostText(slot.cost)
		newButton.SetDescription(slot.description)
		newButton.SetMaxStack(slot.numberOfStacks)
		newButton.texture.texture = slot.texture
		newButton.costIncrease = slot.costIncrease
		newButton.connect("TestBuy",self,"AddUpgrade")
		newButton.shopSlot = slot
		if ResourceLoader.exists(saveName):
			if saveStat.stacks.has(newButton.shopSlot.resource_path):
				for i in saveStat.stacks[newButton.shopSlot.resource_path]:
					newButton.AddToStack()
		

func StartGame() -> void:
	SetPlayerShopStat()
	SetSwordShopStat()
	saveStat.coins = coin
	saveStat.discoveredItems = GameHandler.discoveredItems
	ResourceSaver.save(saveName,saveStat)
	StartGameScene()

func SetPlayerShopStat() -> void:
	var stat:Stat = Stat.new()
	for slot in shopTab.get_node("Player"+"/GridContainer").get_children():
		var shopSlotUI:ShopSlotButton = slot
		stat.health += shopSlotUI.shopSlot.stat.health * shopSlotUI.stack
		stat.speed += shopSlotUI.shopSlot.stat.speed * shopSlotUI.stack
		stat.damage += shopSlotUI.shopSlot.stat.damage * shopSlotUI.stack
		saveStat.stacks[shopSlotUI.shopSlot.resource_path] = shopSlotUI.stack
	GameHandler.shopPlayerStat = stat

func SetSwordShopStat() -> void:
	var stat:Stat = Stat.new()
	for slot in shopTab.get_node("Sword"+"/GridContainer").get_children():
		var shopSlotUI:ShopSlotButton = slot
		var shopSlotStat:Stat = shopSlotUI.shopSlot.stat
		saveStat.stacks[shopSlotUI.shopSlot.resource_path] = shopSlotUI.stack
		if !is_instance_valid(shopSlotStat):
			continue
		stat.health += shopSlotStat.health * shopSlotUI.stack
		stat.speed += shopSlotStat.speed * shopSlotUI.stack
		stat.damage += shopSlotStat.damage * shopSlotUI.stack
	GameHandler.shopSwordStat = stat

func StartGameScene() -> void:
	get_tree().change_scene_to(next_scene)

func _on_Button_pressed() -> void:
	StartGame()
