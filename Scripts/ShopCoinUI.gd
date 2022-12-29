extends HBoxContainer
class_name ShopCoinUI
export var displayCoins = 0
export var valueColor = Color(1,1,0,1)
export var zeroColor = Color(0.1,0.1,0.1,1)
var displayDigits = Array()
func _ready():
	displayDigits = get_children()
	ChangeCoins(displayCoins)
func ChangeCoins(var coins:int):
	displayCoins = coins
	var digitsStack:Array = GetDigits(displayCoins)
	var stackSize = digitsStack.size()
	var zerosToAdd = 5 - stackSize
	for displayDigit in displayDigits:
		var label:Label = displayDigit.get_node("Label")
		label.set("custom_colors/font_color", valueColor)
	for i in zerosToAdd:
		var label:Label = displayDigits[i].get_node("Label")
		label.set("custom_colors/font_color", zeroColor)
		digitsStack.push_front(0)
	var index = 0
	while digitsStack.size() > 0:
		var digit = digitsStack.pop_front()
		UpdateDigitUI(index, digit)
		index+= 1
func UpdateDigitUI(index, digit):
	var label = displayDigits[index].get_node("Label")
	label.text = str(digit)
func GetDigits(var num):
	var number = num
	var stack = Array()
	while number > 0:
		stack.push_front(number%10)
		number = number / 10;
	return stack
