extends Node3D


@export var npcs: int = 100
@export var area_size = 250.
@export var reticle_delay = 1.
var reticle_time = 0.
var score: int = 0
var time = 0.

func _ready():
	pass

func _process(delta):
	time += delta
	
	if reticle_time > 0.:
		reticle_time -= delta
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
	reticle_time = reticle_delay

func get_wave(x, level):
	return - fmod(time + 0.3*x, 60.) - level * 60
