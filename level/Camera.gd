extends Camera3D


@export var speed = 1.
@onready var player = $"../Player"

func _ready():
	pass

func _physics_process(delta):
	look_at(player.position)
	
	var target: Vector3 = player.position + player.basis.z * 5 + Vector3.UP * 3
	position += (target - position) * speed * delta
