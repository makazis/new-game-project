extends TextureRect

var speed = 80
func _process(delta: float) -> void:
	position.x -= delta * speed
	if position.x < -80:
		position.x += 80
