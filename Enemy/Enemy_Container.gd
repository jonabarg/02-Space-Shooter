extends Node2D

onready var Enemy = load("res://Enemy/enemy.tscn")

func _physics_process(_delta):
	Global.update_enemies()
	if get_child_count() < Global.enemies:
		var enemy = Enemy.instance()
		add_child(enemy)
