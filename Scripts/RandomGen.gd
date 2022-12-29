extends Object
class_name RandomGen

func RandomCircle(radius:float, center:Vector2) -> Vector2:
	var direction:Vector2 = Vector2(rand_range(-1.0,1.0),rand_range(-1.0,1.0))
	direction = direction.normalized()
	var randomPos = center + direction * rand_range(0.0,radius)
	return randomPos

func RandomRectangle(height:float, width:float, position:Vector2 = Vector2.ZERO) -> Vector2:
	var randomPos = Vector2(rand_range(position.x, position.x + width), rand_range(position.y, position.y + height))
	return randomPos

func RandomCircleInRect(height:float, width:float, radius:float) -> Vector2:
	var center = Vector2.ZERO
	center += Vector2(rand_range(radius, width-radius), rand_range(radius, height - radius))
	return center
