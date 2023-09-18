class_name Movement
extends Node

export var speed:float = 1.0
export var slowed_speed:float = 0.25
export(NodePath)var damage_taker_path
export(NodePath)var kinematic_body_path
var _normal_speed = 0.0
var kinematic_body

func _ready():
	kinematic_body = get_node(kinematic_body_path)
	var damage_taker:DamageTaker = get_node(damage_taker_path)
	if damage_taker:
		if damage_taker.connect("OnSlowed", self, "on_slowed"):
			print_debug("Connection failed")
		if damage_taker.connect("OnSlowedStop", self, "on_slow_stopped"):
			print_debug("Connection failed")


func move_toward_object(speed_multiplier:float, object) -> bool:
	if !is_instance_valid(object):
		return false
	var direction = object.position - kinematic_body.position
	var _velocity = move(direction, speed_multiplier)
	return true


func move(direction:Vector2, speed_multiplier:float) -> Vector2:
	return kinematic_body.move_and_slide(direction.normalized()*(speed*speed_multiplier))


func on_slowed():
	_normal_speed = speed
	speed = slowed_speed * speed


func on_slow_stopped():
	speed = _normal_speed
