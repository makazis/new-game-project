extends Area2D

var juice_particles = []

func _process(delta: float) -> void:
    position = get_global_mouse_position()

func _on_body_entered(body:Node2D) -> void:
    if body.is_in_group("Liquid"):
        juice_particles.append(body)
        body.modulate = Color(1,1,1,0.2)

func _on_body_exited(body:Node2D) -> void:
    if body.is_in_group("Liquid"):
        var found = juice_particles.find(body)
        if found != -1:
            body.modulate = Color(1,1,1,1)
            juice_particles.remove_at(found)

