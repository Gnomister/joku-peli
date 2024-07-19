extends Area2D


func _on_body_entered(body):
	if body is RigidBody2D:
		body.queue_free()
		print("entered alamaali")


