extends Node2D


onready var player:Player = $Player


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().call_group("ENEMIES", "set_player", player)
	player.inventory.AddItem("Knife", 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for enemy in get_tree().get_nodes_in_group("ENEMIES"):
		enemy.get_node("Label").text = enemy.state_machine.current_state.get_name()
