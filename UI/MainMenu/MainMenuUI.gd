extends Control

var next_scene = load("res://Scenes/GameScene.tscn")
var _shop_scene = load("res://UI/ShopUI/ShopUI.tscn")
var startPos = Vector2.ZERO
var endPos
onready var tween = $Tween
onready var options = $OptionMenu
onready var playerTexture = $PlayerTexture
func _ready():
	get_tree().paused = false
	startPos = playerTexture.rect_position
	endPos = playerTexture.rect_position - Vector2(0.0, 20.0)

func StartGame():
	SaveLoad.loadJSON()
	if SaveLoad.file_exists():
		get_tree().change_scene_to(_shop_scene)
		return
	get_tree().change_scene_to(next_scene)

func QuitGame():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().quit() # default behavior

func _on_PlayButton_pressed():
	StartGame()

func _on_QuitButton_pressed():
	QuitGame()

func _on_OptionButton_pressed():
	DisplayOptions()
func DisplayOptions():
	options.visible = true


func _on_Button_mouse_entered():
	tween.stop_all()
	tween.interpolate_property(
			playerTexture, "rect_position", null, endPos,
			0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()


func _on_Button_mouse_exited():
	tween.stop_all()
	tween.interpolate_property(
			playerTexture, "rect_position", null, startPos,
			1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
