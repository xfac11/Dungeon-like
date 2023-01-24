extends Label
var _total_seconds = 0.0
var _total_minutes = 0.0
func OnTick(seconds):
	_total_seconds+= seconds
	if _total_seconds > 59:
		_total_seconds -= 60
		_total_minutes += 1
	
	var textString = _generate_time_text(_total_minutes, _total_seconds)
	text = textString


func _generate_time_text(minutes, seconds):
	var text = ""
	if minutes < 10:
		text += "0"
	text += String(minutes)
	text += ":"
	if seconds < 10:
		text += "0"
	text += String(seconds)
	return text


func _on_Timer_timeout():
	OnTick(1)
