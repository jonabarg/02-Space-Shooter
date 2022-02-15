extends "res://Ships/Ship.gd"


var y_positions = range(0, 2400, 100)
var x_positions = range(0, 2400, 100)
var has_shield = range(0, 10, 1)
var initial_position = Vector2.ZERO
var direction = Vector2(1.5,0)
var Player = get_node_or_null("/root/Game/Player_Container/Player")
var Ship = get_node_or_null("/root/Game/Ships")
var distance
var d
var tracking = false
var following = false

func _ready():
	initial_position.x = x_positions[randi() % x_positions.size()]
	initial_position.y = y_positions[randi() % y_positions.size()]
	position = initial_position
	max_speed = 200

func get_input():
	Player = get_node_or_null("/root/Game/Player_Container/Player")
	if Player != null:
		distance = position.distance_to(Player.position)
		d = global_position.angle_to_point(Player.global_position) - PI/2
		if following:
			$BlueThrust.show()
			$BlueThrust2.show()
			return -position.rotated(d)
		else:
			$BlueThrust.hide()
			$BlueThrust2.hide()
	return velocity

func _physics_process(_delta):
	Player = get_node_or_null("/root/Game/Player_Container/Player")
	if Player != null:
		distance = position.distance_to(Player.position)
		d = global_position.angle_to_point(Player.global_position) - PI/2
		if tracking:
			self.rotation = d

func _on_Timer_timeout():
	if tracking:
		shoot()
	

func _on_Timer2_timeout():
	if Player != null:
		if distance < 800:
			tracking = true
		else:
			tracking = false
		if distance > 200 and tracking:
			following = true
		else:
			following = false
			velocity -= velocity/(max_speed/speed)
