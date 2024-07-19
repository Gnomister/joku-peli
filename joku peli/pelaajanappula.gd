extends RigidBody2D

var gravity = -100


#
#poistaa nappulan sen päästessä johonkin päätyyn
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
# 
# 
# 
# 
# 
# 
#
#
#
#
#
#
