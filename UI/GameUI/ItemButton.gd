extends Button

var itemName
onready var itemTexture = $ItemTexture
onready var itemDescription = $Panel/Label
onready var itemNameLabel = $Panel/Label2
signal ItemPressed(name)
func _ready():
	var _unused = connect("pressed",self,"SendItem")
func SendItem():
	emit_signal("ItemPressed",itemName)
