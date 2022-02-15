extends "res://Ships/Ship.gd"

var Ship = get_node_or_null("/root/Game/Ships")
onready var Shield = load("res://Ships/Shield.tscn")
var lives = 5

func _ready():
	health = 10
	speed = 3	

func _physics_process(_delta):
	Ship = get_node_or_null("/root/Game/Ships")
	if Input.is_action_just_pressed("shoot"):
		shoot()

func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("forward"):
		to_return.y -= 1
		$Exhaust.show()
	else:
		if velocity != Vector2.ZERO:
			velocity -= velocity/(max_speed/speed)
			
	if Input.is_action_pressed("left"):
		rotation_degrees = rotation_degrees - rotation_speed
	if Input.is_action_pressed("right"):
		rotation_degrees = rotation_degrees + rotation_speed
	return to_return.rotated(rotation)

