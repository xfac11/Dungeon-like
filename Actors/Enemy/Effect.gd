class_name Effect
extends Node2D

export var particles_path:NodePath

onready var particles = get_node(particles_path)

func start_effect():
	particles.emitting = true


func end_effect():
	particles.emitting = false
