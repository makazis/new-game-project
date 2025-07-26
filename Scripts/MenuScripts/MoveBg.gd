extends TextureRect

var speed = 80
func _process(delta: float) -> void:
	position.x -= delta * speed
	if position.x < -800:
		position.x += 800
