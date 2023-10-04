class_name FireEffect
extends Effect

export(NodePath)var damage_taker_path


func _ready():
	var damage_taker:DamageTaker = get_node(damage_taker_path)
	damage_taker.connect("fire_started", self, "_on_DamageTaker_fire_started")
	damage_taker.connect("fire_stopped", self, "_on_DamageTaker_fire_stopped")


func _on_DamageTaker_fire_started():
	.start_effect()


func _on_DamageTaker_fire_stopped():
	.end_effect()

