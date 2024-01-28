extends Camera3D


@export var speed = 1.
@onready var player = $"../Player"

func _process(delta):
	if in_water():
		$Waves.playing = false
		if not $Underwater.playing:
			$Underwater.playing = true
	else:
		$Underwater.playing = false
		if not $Waves.playing:
			$Waves.playing = true

func _physics_process(delta):
	look_at(player.position)
	
	var target: Vector3 = player.position + player.basis.z * 5 + Vector3.UP * 3
	position += (target - position) * speed * delta

func in_water():
	return position.y <= 0
