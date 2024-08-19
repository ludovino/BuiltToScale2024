extends Node3D

func cast() -> void:
	$AnimationPlayer.play("cast2")
	$AnimationPlayer.queue("Idle")
	
func pray() -> void:
	$AnimationPlayer.play("cast1")
	$AnimationPlayer.queue("Idle")
