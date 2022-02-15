extends "res://Ships/Ship.gd"

func _ready():
	health = 50

func damage(d):
	health -= d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
			hide()
			yield(explosion, "animation_finished")
			explosion.queue_free()
		$CollisionShape2D.set_deferred("disabled", true)
		$CollisionShape2D2.set_deferred("disabled", true)
	else:
		$CollisionShape2D.set_deferred("disabled", false)
		$CollisionShape2D2.set_deferred("disabled", false)


	
