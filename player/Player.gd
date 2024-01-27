extends RigidBody3D
class_name Player


@export var force = 1.
@export var rotation_force = 1.
@export var boost_multiplier = 2.
@export var air_controll = 1.
var tornados = 0

func _ready():
	$Pivot/Shark/AnimationPlayer.get_animation("Armature|ArmatureAction").set_loop_mode(Animation.LoopMode.LOOP_LINEAR)
	$Pivot/Shark/AnimationPlayer.play("Armature|ArmatureAction")

func _physics_process(delta):
	var f = -basis.z * force
	if in_tornado():
		apply_force(Vector3.UP * 20 * mass)
	elif in_water():
		apply_force(Vector3.UP * 9 * mass)
	else:
		f *= air_controll
		f -= Vector3.UP * (f.dot(Vector3.UP))
	if Input.is_action_pressed("boost"):
		f *= boost_multiplier
		$Pivot/Shark/AnimationPlayer.speed_scale = boost_multiplier
	else:
		$Pivot/Shark/AnimationPlayer.speed_scale = 1
	apply_force(f)
	
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

func in_water():
	return position.y <= 0

func in_tornado():
	return tornados > 0
