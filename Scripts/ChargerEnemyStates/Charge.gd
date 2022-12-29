extends State
class_name Charge
var playerDirection = Vector2(0,0)
var radius = 1
var touchedPlayer = false
var seconds = 0
var overCharge = 5
func Enter(object:MovementAI):
	seconds = 0
	playerDirection = object.GetVectorToPlayer()
func Exit(_object):
	pass
func InputUpdate(_event, object:MovementAI, _delta) -> State:
	if seconds > overCharge || touchedPlayer:
		return stateDictionary["Staggered"]
	return null
func Update(object:MovementAI, delta):
	if object.IsCloseToPlayer(radius):
		touchedPlayer = true
	seconds+= delta
	object.Move(playerDirection,5)
