class_name PoisonEffect
extends Effect

export(NodePath)var damage_taker_path


func _ready():
	var damage_taker:DamageTaker = get_node(damage_taker_path)
	damage_taker.connect("poison_started", self, "_on_DamageTaker_poison_started")
	damage_taker.connect("poison_stopped", self, "_on_DamageTaker_poison_stopped")


func _on_DamageTaker_poison_started():
	.start_effect()


func _on_DamageTaker_poison_stopped():
	.end_effect()
