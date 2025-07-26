extends Camera2D

var camera_zoom = 1
var mouse_previous_position = Vector2(0,0)
var just_pressed = false

func _input(event):
	if Global.drag_locked:
		return
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			camera_zoom *= 1.1
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			camera_zoom *= 0.9
	Global.camera_zoom=camera_zoom
func _process(delta: float) -> void:
	if Global.drag_locked:
		return
	zoom = Vector2.ONE * camera_zoom
	scale = Vector2.ONE / camera_zoom
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if just_pressed:
			just_pressed = false
			mouse_previous_position = get_viewport().get_mouse_position()
		position += (mouse_previous_position - get_viewport().get_mouse_position()) / camera_zoom
		Global.camera_pos=position
		mouse_previous_position = get_viewport().get_mouse_position()
	else:
		just_pressed = true
