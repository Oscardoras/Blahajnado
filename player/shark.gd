extends Node3D


func _ready():
	$AnimationPlayer.get_animation("Armature|ArmatureAction").set_loop_mode(Animation.LoopMode.LOOP_LINEAR)
	$AnimationPlayer.play("Armature|ArmatureAction")
