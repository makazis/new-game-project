extends Node

var direction = 0
var building
var direction_vector=Vector2(-1,0)

func _ready() -> void:
	if has_node("AnimatedSprite2D"):
		$"AnimatedSprite2D".play("default")
		if Global.first_animator==null:
			Global.first_animator=$"AnimatedSprite2D"
		else:
			$"AnimatedSprite2D".set_frame_and_progress(Global.first_animator.get_frame()%$"AnimatedSprite2D".sprite_frames.get_frame_count("default"),Global.first_animator.get_frame_progress())
