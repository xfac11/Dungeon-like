extends Node

var data:SaveStats = SaveStats.new() ##Persistent data at runtime
var _file:File = File.new()

var SAVE_GAME_PATH = "user://save.json"


func file_exists() -> bool:
	return _file.file_exists(SAVE_GAME_PATH)

##Overwrite the data with the data in SAVE_GAME_PATH
func loadJSON() -> void:
	if !_file.file_exists(SAVE_GAME_PATH):
		return
	var error := _file.open(SAVE_GAME_PATH, File.READ)
	if error != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" % [SAVE_GAME_PATH, error])
		return;
	
	var text = _file.get_as_text()
	_file.close()
	var jsonResult:JSONParseResult = JSON.parse(text)
	var jsonDictionary = jsonResult.result
	
	data = SaveStats.new() ##Overwrite
	data.shop_stacks = jsonDictionary["shop_stacks"]
	data.coins = jsonDictionary["coins"]
	var itemDictionary = jsonDictionary["discovered_items"]
	for item in itemDictionary:
		data.discovered_items.append(itemDictionary[item])
	

##Take the data and save it to SAVE_GAME_PATH
func saveJSON() -> void:
	var error := _file.open(SAVE_GAME_PATH, File.WRITE)
	if error != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" %[SAVE_GAME_PATH, error])
		return
	
	var saveData:Dictionary = {
		"shop_stacks" : data.shop_stacks,
		"discovered_items" : {},
		"coins" : data.coins,
	}
	for i in data.discovered_items.size():
		 saveData["discovered_items"][i] = data.discovered_items[i]
	var json_string = JSON.print(saveData)
	_file.store_string(json_string)
	_file.close()

func reset() -> void:
	var dir = Directory.new()
	dir.remove(SAVE_GAME_PATH)
	data = SaveStats.new()
