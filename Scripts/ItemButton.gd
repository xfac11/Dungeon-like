extends Button

var itemName
onready var itemTexture = $ItemTexture
signal ItemPressed(name)
func _ready():
	var _unused = connect("pressed",self,"SendItem")
func SendItem():
	emit_signal("ItemPressed",itemName)
