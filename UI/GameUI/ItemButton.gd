extends Button

var itemName
onready var itemTexture = $ItemTexture
onready var itemDescription = $Panel/VBoxContainer/Label
onready var itemNameLabel = $Panel/VBoxContainer/Label2
onready var itemStatsLabel = $Panel/VBoxContainer/Label3
signal ItemPressed(name)
func _ready():
	var _unused = connect("pressed",self,"SendItem")
func SendItem():
	emit_signal("ItemPressed",itemName)
