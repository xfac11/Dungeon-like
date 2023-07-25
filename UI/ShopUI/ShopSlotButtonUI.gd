tool
extends Button
class_name ShopSlotButton

var stack = 0
var maxStack = 5
var costIncrease = 0
export var shopSlot:Resource setget set_shop_slot, get_shop_slot
onready var texture:TextureRect = $Texture
onready var description:Label = $Description
onready var stackLabel:Label = $Stacks
onready var costLabel:Label = $Cost
signal TestBuy(cost,slot)

func set_shop_slot(value:ShopSlot):
	shopSlot = value
	if !is_instance_valid(value):
		return
	get_node("Cost").text = str(shopSlot.cost)
	$Description.text = str(shopSlot.description)
	$Stacks.text = str(stack)
	$Texture.texture = shopSlot.texture
	


func get_shop_slot():
	return shopSlot

func _ready():
	connect("pressed",self,"CanBuy")
func CanBuy():
	emit_signal("TestBuy",int(costLabel.text),self)
func AddToStack():
	SetCostText(costIncrease+int(costLabel.text))
	stack += 1
	stackLabel.text = str(stack)
	if stack >= maxStack:
		disabled = true
		stackLabel.text = str(stack) + " (MAX)"
		return
func SetCostText(cost:int):
	costLabel.text = str(cost)
func SetDescription(text:String):
	description.text = text
func SetMaxStack(maximum:int):
	maxStack = maximum
