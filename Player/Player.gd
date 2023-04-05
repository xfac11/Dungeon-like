class_name Player
extends KinematicBody2D

const ItemTypeResource = preload("res://ItemResources/ItemType.gd")

var inventoryResource = preload("res://Player/Inventory.gd")
var inventory:Inventory = inventoryResource.new()
var playerStatResource = load("res://Stats/PlayerStat.tres")
var baseStat:Stat = playerStatResource
var currentStat:Stat = Stat.new()
var itemHandler:HandleItems = HandleItems.new()
var coins = 0

onready var experienceSystem:ExperienceSystem = $ExperienceSystem
onready var sprite = $Sprite
onready var pivot = $Pivot
onready var timer = $Timer
onready var health:Health = $DamageTaker/Health
onready var pickUpArea:PickupArea = $PickupArea
onready var damageTaker:DamageTaker = $DamageTaker
signal coin_picked(coins)
export(PackedScene)var pickUpAnimation
func _ready() -> void:
	inventory.Clear()
	SetBaseStat()
	inventory.connect("inventoryChanged",self,"ApplyStat")
	timer.connect("timeout",self,"ProcessItems")
	pickUpArea.SetCharacter(self)


func _physics_process(_delta:float) -> void:
	var velocity = Vector2(0,0)
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
		pivot.rotation_degrees = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -1
		pivot.rotation_degrees = 180
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
		pivot.rotation_degrees = 90
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -1
		pivot.rotation_degrees = 270
	var _unused = move_and_slide(velocity.normalized()*currentStat.speed)


func GiveExp(value):
	experienceSystem.AddExperience(value)


func GiveCoin(value):
	coins += value
	emit_signal("coin_picked", coins)


func ProcessItems() -> void:
	var itemSlots:Array = inventory.GetItems()
	for slot in itemSlots:
		var itemSlot:Inventory.ItemSlot = slot
		var item:Item = itemSlot.item
		var nrOfStacks:int = itemSlot.nrOfStacks
		
		if item.itemStat.itemType == ItemTypeResource.ItemType.WEAPON:
			itemHandler.Shoot(item, nrOfStacks, owner, global_transform)


func ApplyStat(_items:Array, newItemName:String, stacks:int) -> void:
	var item:Item = ItemDatabase.GetItem(newItemName)
	if item.itemStat.itemType == ItemTypeResource.ItemType.PASSIVE:
		currentStat.AddStat(item.itemStat, stacks)
		health.SetHealth(currentStat.health)


func SetBaseStat() -> void:
	currentStat.health = baseStat.health
	currentStat.damage = baseStat.damage
	currentStat.speed = baseStat.speed
	currentStat.healthRegen = baseStat.healthRegen
	
	currentStat.AddStat(GameHandler.shopPlayerStat, 1)
	health.SetHealth(currentStat.health)
	health.SetCurrentHealth(currentStat.health)


func _on_Health_damageTaken(currentHealth, maximumHealth, damageAmount):
	var tween = get_node("Tween")
	tween.interpolate_property(sprite.material, "shader_param/blinkValue",
		1, 0, 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	$DamageTimer.start()
	$HPRegTimer.stop()


func _on_HPRegTimer_timeout():
	health.Heal(currentStat.healthRegen)
	if health.currentHealth == health.maximumHealth:
		$HPRegTimer.stop()


func _on_DamageTimer_timeout():
	$HPRegTimer.start()


func _on_PickupArea_item_picked_up(loot):
	$Particles2D.emitting = true
	var object = pickUpAnimation.instance()
	self.add_child(object)
	object.texture = loot.get_node("Sprite").texture
	object.scale = loot.get_node("Sprite").scale
	return object
	
