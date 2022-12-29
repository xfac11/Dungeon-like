extends Node
var items = Array()

func _ready() -> void:
	var directory = Directory.new()
	directory.open("res://Items")
	directory.list_dir_begin()
	
	var filename = directory.get_next()
	while filename:
		if not directory.current_is_dir():
			items.append(load("res://Items/%s" % filename))
			
		filename = directory.get_next()
	

func GetItem(item_name : String) -> Item:
	for i in items:
		if i.name == item_name:
			return i
		
	return null

func GetRandomItem() -> Item:
	var randomIndex:int = randi() % items.size()
	return items[randomIndex]
