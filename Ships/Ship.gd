extends KinematicBody2D

var velocity = Vector2.ZERO

var rotation_speed = 5.0
var speed = 5
var max_speed = 400.0
var health = 1
var dead = false

var Effects = null
onready var Explosion = load("res://Effects/Explosion.tscn")

onready var Bullet = load("res://Ships/Bullet.tscn")
var nose = Vector2(0,-70)

func _ready():
	pass


func _physics_process(_delta):
	velocity = velocity + get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	velocity = move_and_slide(velocity, Vector2.ZERO)
	#position.x = wrapf(position.x, 0, Global.VP.x)
	#position.y = wrapf(position.y, 0, Global.VP.y)
	position.x = clamp(position.x, 0, 2400)
	position.y = clamp(position.y, 0, 2400)
	
func get_input():
	pass
	
func damage(d):
	if health <= 0:
		if not dead:
			dead = true
			Effects = get_node_or_null("/root/Game/Effects")
			if Effects != null:
				var explosion = Explosion.instance()
				Effects.add_child(explosion)
				explosion.global_position = global_position
				hide()
				yield(explosion, "animation_finished")
			if self.name == "Player":
				Global.update_lives(-1)
			else:
				Global.update_score(500)
				Global.update_time(2)
				Global.enemies -= 1
			queue_free()
	else: 
		health -= d
		
func _on_Area2D_body_entered(body):
	if body.name != self.name and velocity != Vector2.ZERO:
		body.damage(50)
		damage(50)
		
func shoot():
	if not dead:
		var Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var bullet = Bullet.instance()
			bullet.global_position = global_position + nose.rotated(rotation)
			bullet.rotation = rotation
			Effects.add_child(bullet)
