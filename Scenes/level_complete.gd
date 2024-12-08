extends Area2D


func _on_level_complete_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().get_current_scene().get_node("Player").finish_game()
		$AnimationPlayer.play("pickup")
		$CollisionShape2D.set_deferred("disabled", true)
