extends ColorRect

onready var confirmation_reset:ConfirmationDialog = $ConfirmationDialog
onready var resolutionsOptBtn:OptionButton = $ResolutionOptBtn
onready var windowModesOptBtn:OptionButton = $WindowModeOptBtn
var _saveName = "res://Saves/new_save1.tres"
const SETTINGSFILE = "user://settings.JSON"
enum WindowMode {
	Fullscreen = 1,
	Windowed = 0
}
var windowModeDict = {"Fullscreen" : WindowMode.Fullscreen,
						"Windowed" : WindowMode.Windowed}
var resolutionDict = {"1920x1080" : Vector2(1920,1080),
						"1280x720" : Vector2(1280,720),
						"800x600" : Vector2(800,600)}
var saveSettings = {"resolution" : "1920x1080",
					 "windowMode" : WindowMode.Windowed}
func _init():
	var file = File.new()
	if file.file_exists(SETTINGSFILE):
		LoadSettings(SETTINGSFILE)

func _ready():
	OS.set_window_size(resolutionDict[saveSettings["resolution"]])
	OS.set_window_fullscreen(bool(saveSettings["windowMode"]))
	FillItemsWithResolutions(resolutionDict)
	FillItemsWithWindowModes(windowModeDict)
	SetSelectResolutions()
	SetSelectWindowmode()
	confirmation_reset.get_ok().text = "Yes"
	confirmation_reset.get_cancel().text = "No"

func _on_click_resolutions(resolution):
	OS.set_window_size(resolutionDict[resolution])
	saveSettings["resolution"] = resolution
	SaveSettings(SETTINGSFILE)

func _on_click_windowmode(mode):
	OS.set_window_fullscreen(bool(windowModeDict[mode]))
	saveSettings["windowMode"] = windowModeDict[mode]
	SaveSettings(SETTINGSFILE)

func LoadSettings(filename:String) -> void:
	var file:File = File.new()
	file.open(filename, File.READ)
	var jsonStr:String = file.get_as_text()
	var jsonResult:JSONParseResult = JSON.parse(jsonStr)
	if jsonResult.result is Dictionary:
		saveSettings = jsonResult.result
	else:
		print_debug("JSON result from: " + filename + " is not a Dictionary")
	file.close()

func SaveSettings(filename):
	var file:File = File.new()
	file.open(filename, File.WRITE)
	var jsonStr:String = to_json(saveSettings)
	file.store_string(jsonStr)
	file.close()

func FillItemsWithResolutions(dictionary):
	for item in dictionary:
		resolutionsOptBtn.add_item(item)

func FillItemsWithWindowModes(dictionary):
	for item in dictionary:
		windowModesOptBtn.add_item(item)

func SetSelectResolutions():
	for i in resolutionsOptBtn.get_item_count():
		var itemText = resolutionsOptBtn.get_item_text(i)
		if itemText == saveSettings["resolution"]:
			resolutionsOptBtn.select(i)

func SetSelectWindowmode():
	for i in windowModesOptBtn.get_item_count():
		var itemText = windowModesOptBtn.get_item_text(i)
		var windowModeText = "Fullscreen" if bool(saveSettings["windowMode"]) else "Windowed"
		if itemText == windowModeText:
			windowModesOptBtn.select(i)

func _on_ResolutionOptBtn_item_selected(index):
	var resolution = resolutionsOptBtn.get_item_text(index)
	_on_click_resolutions(resolution)


func _on_WindowModeOptBtn_item_selected(index):
	var windowMode = windowModesOptBtn.get_item_text(index)
	_on_click_windowmode(windowMode)


func _on_BackToMenuBtn_pressed():
	visible = false


func _on_ResetButton_pressed():
	confirmation_reset.popup()


func _on_ConfirmationDialog_confirmed():
	SaveLoad.reset()
