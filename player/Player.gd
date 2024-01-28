extends RigidBody3D
class_name Player


@export var force = 1.
@export var rotation_force = 1.
@export var boost_force = 2.
@export var boost_delay = 1.
@export var air_controll = 1.
var tornados = 0
var boost_time = 0.

func _ready():
	$Pivot/Shark/AnimationPlayer.get_animation("Armature|ArmatureAction").set_loop_mode(Animation.LoopMode.LOOP_LINEAR)
	$Pivot/Shark/AnimationPlayer.play("Armature|ArmatureAction")

func _process(delta):
	if boost_time > 0:
		boost_time -= delta

func _physics_process(delta):
	var f = -basis.z * force
	if in_tornado():
		apply_force(Vector3.UP * 20 * mass)
	elif in_water():
		apply_force(Vector3.UP * 9 * mass)
	else:
		f *= air_controll
		f -= Vector3.UP * max(0., f.dot(Vector3.UP))
	
	if boost_time <= 0.:
		apply_force(f)
		if Input.is_action_just_pressed("boost"):
			for target in $Detector.get_overlapping_bodies():
				if target is NPC:
					var direction = (target.position + 0.5*target.velocity - position).normalized()
					linear_velocity = Vector3()
					apply_impulse(direction * boost_force)
					boost_time = boost_delay
					break
	
	if Input.is_action_pressed("move_left"):
		apply_torque(Vector3.UP * rotation_force)
	if Input.is_action_pressed("move_right"):
		apply_torque(Vector3.UP * -rotation_force)
	
	if Input.is_action_pressed("move_up"):
		if rotation.x < PI/4:
			rotate(basis.x, delta)
	if Input.is_action_pressed("move_down"):
		if rotation.x > -PI/4:
			rotate(basis.x, -delta)

func _on_body_entered(body):
	if body is NPC:
		$Eating.play()
		get_node("/root/Level").new_kill()
		body.queue_free()

func in_water():
	return position.y <= 0

func in_tornado():
	return tornados > 0
