extends State
var seconds = 0
var staggerTime = 5
func Enter(_object):
	seconds = 0
func Exit(_object):
	pass
func InputUpdate(_event, _object, _delta) -> State:
	if seconds > staggerTime:
		return stateDictionary["Walk"]
	return null
func Update(_object, delta):
	seconds+= delta
