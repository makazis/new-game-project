extends Camera2D

var camera_zoom = 1

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_LEFT :
				print("Left mouse button")
			if event.button_index == MOUSE_BUTTON_WHEEL_UP :
				camera_zoom *= 1.1
				print("Up")
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				camera_zoom *= 0.9
		elif event.is_released():
			pass

func _process(delta: float) -> void:
	zoom = Vector2.ONE * camera_zoom
