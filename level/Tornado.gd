extends Area3D


@export var speed = 1.
var direction: Vector2

func _ready():
	direction = Vector2((-0.5+randf())*2*speed, (-0.5+randf())*2*speed)

func _process(delta):
	if not $Wind.playing:
		$Wind.playing = true

func _on_body_entered(body):
	if body is Player:
		body.tornados += 1

func _on_body_exited(body):
	if body is Player:
		body.tornados -= 1
