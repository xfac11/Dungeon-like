extends Button
class_name ShopSlotButton

var stack = 0
var maxStack = 5
var costIncrease = 0
var shopSlot:ShopSlot
onready var texture:TextureRect = $Texture
onready var description:Label = $Description
onready var stackLabel:Label = $Stacks
onready var costLabel:Label = $Cost
signal TestBuy(cost,slot)
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
