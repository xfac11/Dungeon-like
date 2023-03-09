extends Node

export(PackedScene)var text2DTimerScene
export(NodePath)var vfxOverAllPath

func spawn_object(packedScene, parent):
	var object = packedScene.instance()
	parent.add_child(object)
	object.transform = parent.transform
	return object


func create_text(fontColor, position, animation, text):
	var text2D_timer = spawn_object(text2DTimerScene, get_node(vfxOverAllPath))
	text2D_timer.position = position
	text2D_timer.animation = animation
	var text2D:Text2D = text2D_timer.text2D
	text2D.font_color = fontColor
	text2D.text = text
	text2D_timer.start_animation()


func damage_popup(damageAmount, isCrit, parent, damageSrc):
	if isCrit:
		create_text(Color.yellow, parent.global_position, "PopupFadeOutCrit", damageAmount)
	else:
		create_text(Color.white, parent.global_position, "PopupFadeOut", damageAmount)


func _on_player_DamageTaker_dodged(parent):
	create_text(Color.beige, parent.global_position, "PopupFadeOut", "Dodged!")
