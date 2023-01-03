extends KinematicBody2D
class_name Player

onready var experienceSystem:ExperienceSystem = $ExperienceSystem
onready var animatedSprite = $AnimatedSprite
onready var pivot = $Pivot
onready var timer = $Timer
onready var health:Health = $Health
onready var pickUpArea:PickupArea = $PickupArea

const ItemTypeResource = preload("res://Scripts/ItemType.gd")
var inventoryResource = preload("res://Player/Inventory.gd")
var inventory:Inventory = inventoryResource.new()
var playerStatResource = load("res://Stats/PlayerStat.tres")
var baseStat:Stat = playerStatResource
var currentStat:Stat = Stat.new()
var itemHandler:HandleItems = HandleItems.new()
var coins = 0

const right = Vector2(1,0)
const left = Vector2(-1,0)
const up = Vector2(0,-1)
const down =  Vector2(0,1)

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
func _process(_delta:float) -> void:
	#if Input.is_action_pressed("ui_right"):
	#	animatedSprite.play("right_walk")
	#else:
	#	animatedSprite.stop()
	if Input.is_action_pressed("ui_right"):
		animatedSprite.play("right_walk")
	elif Input.is_action_pressed("ui_left"):
		animatedSprite.play("left_walk")
	elif Input.is_action_pressed("ui_down"):
		animatedSprite.play("down_walk")
	elif Input.is_action_pressed("ui_up"):
		animatedSprite.play("up_walk")
	else:
		animatedSprite.stop()

func ProcessItems() -> void:
	var itemSlots:Array = inventory.GetItems()
	for slot in itemSlots:
		var itemSlot:Inventory.ItemSlot = slot
		var item:Item = itemSlot.item
		var nrOfStacks:int = itemSlot.nrOfStacks
		
		if item.itemType == ItemTypeResource.ItemType.WEAPON:
			itemHandler.Shoot(item, nrOfStacks, owner, global_transform)
		

func ApplyStat(_items:Array, newItemName:String, stacks:int) -> void:
	var item:Item = ItemDatabase.GetItem(newItemName)
	currentStat.health += item.health*stacks
	currentStat.speed += item.speed*stacks
	currentStat.armor += item.armor*stacks
	health.SetHealth(currentStat.health)

func SetBaseStat() -> void:
	currentStat.health = baseStat.health
	currentStat.damage = baseStat.damage
	currentStat.speed = baseStat.speed
	
	currentStat.health += GameHandler.shopPlayerStat.health
	currentStat.damage += GameHandler.shopPlayerStat.damage
	currentStat.speed += GameHandler.shopPlayerStat.speed


func _on_Health_damageTaken(currentHealth, maximumHealth):
	var tween = get_node("Tween")
	tween.interpolate_property($AnimatedSprite.material, "shader_param/blinkValue",
		1, 0, 0.25,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	