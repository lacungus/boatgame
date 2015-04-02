const LEFT = "left"
const RIGHT = "right"

const VECTOR_LEFT = Vector2(-1, 0)
const VECTOR_RIGHT = Vector2(1, 0)

func opposite(direction):
	if direction == direction.LEFT:
		return RIGHT
	if direction == RIGHT:
		return LEFT
	print("Unable to get opposite direction: " + direction)
	return null
