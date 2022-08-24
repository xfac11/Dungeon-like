extends KinematicBody2D

var inventoryResource = load("res://Inventory.gd")
var inventory = inventoryResource.new()

class Stat:
	var speed:float = 100
	var health:int = 100
	func GetStatStr():
		return "Speed: " + str(speed) + "\n" + "Health: " + str(health) + "\n"
		 
var currentStat:Stat = Stat.new()
onready var _animated_sprite = $AnimatedSprite
onready var timer = $Timer
var right = Vector2(1,0)
var left = Vector2(-1,0)
var up = Vector2(0,-1)
var down =  Vector2(0,1)
export var speed = 100
onready var pivot = $Pivot
var itemHandler:HandleItems = HandleItems.new()
func _ready():
	inventory.connect("inventoryChanged",self,"ApplyStat")
	speed = currentStat.speed
	timer.connect("timeout",self,"ProcessItems")

func _physics_process(_delta):
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
	var _unused = move_and_slide(velocity.normalized()*speed)
	
	


func _process(_delta):
	#if Input.is_action_pressed("ui_right"):
	#	_animated_sprite.play("right_walk")
	#else:
	#	_animated_sprite.stop()
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("right_walk")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.play("left_walk")
	elif Input.is_action_pressed("ui_down"):
		_animated_sprite.play("down_walk")
	elif Input.is_action_pressed("ui_up"):
		_animated_sprite.play("up_walk")
	else:
		_animated_sprite.stop()
	
	
	
	
func ProcessItems():
	var itemSlots = inventory.GetItems()
	for itemSlot in itemSlots:
		var item:Item = itemSlot.item
		var nrOfStacks:int = itemSlot.nrOfStacks
		
		if item.itemType == item.ItemType.WEAPON:
			itemHandler.Shoot(item, nrOfStacks, owner, global_transform)
		

func ApplyStat(_items, newItemName, stacks):
	var item = ItemDatabase.GetItem(newItemName)
	currentStat.health += item.health*stacks
	currentStat.speed += item.speed*stacks
	get_node("Health").SetHealth(currentStat.health)
	speed = currentStat.speed
