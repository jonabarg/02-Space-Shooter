extends KinematicBody2D

var velocity = Vector2.ZERO
var small_speed = 3.0
var initial_speed = 3.0
var health = 1
var initial_position = Vector2.ZERO
var y_positions = range(550, 1800, 200)
var x_positions = range(550, 1800, 200)

onready var Asteroid_small = load("res://Asteroid/Asteroid_small.tscn")
var small_asteroids = [Vector2(0,-30),Vector2(30,30),Vector2(-30,30)]

func _ready():
	initial_position.x = x_positions[randi() % x_positions.size()]
	initial_position.y = y_positions[randi() % y_positions.size()]
	position = initial_position
	velocity = Vector2(0,initial_speed*randf()).rotated(PI*2*randf())

func _physics_process(_delta):
	position = position + velocity
	position.x = wrapf(position.x, -100, 2500)
	position.y = wrapf(position.y, -100, 2500)


func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(100)
		collision_layer = 0
		var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
		if Asteroid_Container != null:
			for s in small_asteroids:
				var asteroid_small = Asteroid_small.instance()
				var dir = randf()*2*PI
				var i = Vector2(0,randf()*small_speed).rotated(dir)
				Asteroid_Container.call_deferred("add_child", asteroid_small)
				asteroid_small.position = position + s.rotated(dir)
				asteroid_small.velocity = i
		queue_free()


func _on_Area2D_body_entered(body):
	var temp = velocity.normalized()
	velocity = body.velocity.normalized()
	body.velocity = temp
