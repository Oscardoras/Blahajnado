extends NPC


@export var direction: Vector3

func _physics_process(delta):
	velocity = direction
	
	move_and_slide()
