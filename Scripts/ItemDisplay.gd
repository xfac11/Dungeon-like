extends Panel

onready var text = $StacksText
onready var itemTexture = $ItemTextureRect
var itemName:String
func UpdateItem(var item:Item, quantity):
	text.text = str(quantity)
	itemName = item.name
	itemTexture.texture = item.texture
