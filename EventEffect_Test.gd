tool
class_name EventEffect_Test
extends Effect

export(NodePath)var damage_taker_path
var _start_signal:String
var _stop_signal:String

func _ready():
	var damage_taker:DamageTaker = get_node(damage_taker_path)
	damage_taker.connect(_start_signal, self, "_on_DamageTaker_started")
	damage_taker.connect(_stop_signal, self, "_on_DamageTaker_stopped")


func _on_DamageTaker_started():
	.start_effect()


func _on_DamageTaker_stopped():
	.end_effect()


func _get_property_list() -> Array:
	var props = []
	if damage_taker_path:
		var signals_names = Array()
		var signal_list = get_node(damage_taker_path).get_signal_list()
		for i in signal_list.size():
			signals_names.append(signal_list[i]["name"])

		var signal_name_string:String
		for i in signals_names:
			signal_name_string += i
			signal_name_string += ","

		props.append(
			{
				'name':'start_signal',
				'type':TYPE_STRING,
				'hint':PROPERTY_HINT_ENUM,
				'hint_string':signal_name_string,
			})
		props.append(
			{
				'name':'stop_signal',
				'type':TYPE_STRING,
				'hint':PROPERTY_HINT_ENUM,
				'hint_string':signal_name_string,
			})
		props.append(
			{
				'name':'damage_taker_path',
				'type':TYPE_NODE_PATH,
			})
	
	return props


func _get(property):
	if property == 'start_signal':
		return _start_signal
	if property == 'stop_signal':
		return _stop_signal
	if property == 'damage_taker_path':
		return damage_taker_path

func _set(property, value):
	if property == 'start_signal':
		_start_signal = value
	if property == 'stop_signal':
		_stop_signal = value
	if property == 'damage_taker_path':
		damage_taker_path = value
	return true
