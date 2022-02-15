extends Node

var VP = Vector2.ZERO

var score = 0
var time = 60
var lives = 5
var max_enemies = 0
var enemies = 0
var nextLife = 1000

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed", self, "_resize")

func _resize():
	VP = get_viewport().size
	
func reset():
	get_tree().paused = false
	score = 0
	time = 60
	lives = 5
	max_enemies = 0
	enemies = 0
	nextLife = 1000

func update_score(s):
	score += s
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if score > nextLife:
		update_lives(1)
		nextLife += nextLife
	if hud != null:
		hud.update_score()

func update_time(t):
	time += t
	if time <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_time()
	
func update_lives(l):
	lives += l
	if lives <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_lives()
func update_enemies():
	if enemies == 0 and score % 1000 == 0:
		enemies += 1
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if max_enemies < 40:
		if 60/(time/2) > max_enemies:
			max_enemies = 60/(time/2)
			enemies = max_enemies
	if hud != null:
		hud.update_enemies()
	
