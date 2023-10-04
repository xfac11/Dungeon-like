extends Node2D


onready var player:Player = $Player
onready var enemy:Enemy = $Enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	player.inventory.AddItem("Knife", 1)
	enemy.set_player(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
