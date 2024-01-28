extends Node3D


@export var npcs: int = 100
@export var area_size = 250.
@export var tornados: int = 5
var score: int = 0
var time = 0.

func _ready():
	for i in range(tornados):
		var tornado = preload("res://level/Tornado.tscn").instantiate()
		$Tornados.add_child(tornado)
		tornado.position = Vector3((-0.5+randf())*2*area_size, 0, (-0.5+randf())*2*area_size)

func _process(delta):
	time += delta
	
	$Control/Score.text = "Score: " + str(score)
	
	if $NPCs.get_child_count() < npcs:
		var npc = preload("res://npcs/Surfer.tscn").instantiate()
		$NPCs.add_child(npc)
		var x = (-0.5+randf())*2*area_size
		npc.position = Vector3(x, 0, get_wave(x, -5 + randi()%10))
	
	for npc: NPC in $NPCs.get_children():
		if npc.position.z < -area_size:
			npc.queue_free()

func new_kill():
	score += 1

func get_wave(x, level):
	return - fmod(time + 0.3*x, 60.) - level * 60
