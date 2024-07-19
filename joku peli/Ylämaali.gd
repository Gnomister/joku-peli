extends Area2D

signal omamaali(value)
#ylämaali
#saaks ylä- ja alamaalii yhelle "koodilehdelle?" Paras tapa?
func _on_body_entered(body):
	if body is RigidBody2D:
		body.queue_free()
		print("entered ylämaali")
		emit_signal("omamaali", -1)
