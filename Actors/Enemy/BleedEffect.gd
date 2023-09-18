class_name BleedEffect
extends Effect

export(NodePath)var damage_taker_path


func _ready():
	var damage_taker:DamageTaker = get_node(damage_taker_path)
	damage_taker.connect("bleed_started", self, "_on_DamageTaker_bleed_started")
	damage_taker.connect("bleed_stopped", self, "_on_DamageTaker_bleed_stopped")


func _on_DamageTaker_bleed_started():
	.start_effect()


func _on_DamageTaker_bleed_stopped():
	.end_effect()
