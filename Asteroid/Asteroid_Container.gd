extends Node2D


onready var Asteroid = load("res://Asteroid/Asteroid.tscn")
var asteroid
var asteroids = 25

func _physics_process(_delta):
	while asteroids > 0:
		asteroids -= 1
		asteroid = Asteroid.instance()
		add_child(asteroid)
		
