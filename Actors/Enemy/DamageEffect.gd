class_name DamageEffect
extends BlinkEffect

export(NodePath) var health_path

func _ready():
	var health_node:Health = get_node(health_path)
	if health_node.connect("damageTaken", self, "_on_Health_damageTaken"):
		print_debug("Connection failed")

func _on_Health_damageTaken(_currentHealth, _maximumHealth, _damageAmount):
	.blink()
