class_name SlowEffect
extends SpriteColorChanger

export(NodePath)var damage_taker_path

func _ready():
	var damage_taker:DamageTaker = get_node(damage_taker_path)
	if damage_taker.connect("OnSlowed", self, "change_to"): 
		print_debug("Connection failed")
	if damage_taker.connect("OnSlowedStop", self, "change_back"):
		print_debug("Connection failed")
