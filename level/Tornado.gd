extends Area3D


var direction: Vector2

func _ready():
	direction = Vector2(-1+randf()*2, -1+randf()*2)

func _on_body_entered(body):
	if body is Player:
		body.tornados += 1

func _on_body_exited(body):
	if body is Player:
		body.tornados -= 1
