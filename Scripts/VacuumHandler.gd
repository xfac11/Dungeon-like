extends Area2D

var expInRange = {}
var playerBody = 0
export var speed = 100
signal pickUpSignal(layer, body)
export var pickupRadius = 5.0
func _ready():
	playerBody = get_parent()

func _on_PickUpArea_body_entered(body):
	expInRange[body] = body


func _on_PickUpArea_body_exited(body):
	if(expInRange.has(body)):
		expInRange.erase(body)

func _physics_process(_delta):
	if(expInRange.size() > 0):
		for key in expInRange:
			var item = expInRange[key]
			var direction = playerBody.position - item.position
			item.move_and_slide(direction.normalized()*speed)
			if direction.length() < pickupRadius:
				var layer = playerBody.get_collision_layer()
				emit_signal("pickUpSignal",layer, playerBody)
				item.queue_free()
			
