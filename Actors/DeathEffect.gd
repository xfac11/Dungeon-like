class_name DeathEffect
extends CircularFadeOut

export(NodePath) var health_path

func _ready():
	var health_node = get_node(health_path)
	if health_node.connect("healthDepleted", self, "_on_Health_healthDepleted"):
		print_debug("Connection failed")


func _on_Health_healthDepleted(_parent):
	.fade_out()
