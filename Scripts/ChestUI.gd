extends Panel
onready var textureRects = $HBoxContainer.get_children()
signal Pause(isPause)
func SetItems(items):
	for rect in textureRects:
		rect.visible = false
	for i in items.size():
		textureRects[i].visible = true
		textureRects[i].texture = ItemDatabase.GetItem(items[i]).texture


func _on_Button_pressed():
	visible = false
	emit_signal("Pause",false)


func _on_Spawner_ChestItemsAdded(itemsAdded):
	SetItems(itemsAdded)
