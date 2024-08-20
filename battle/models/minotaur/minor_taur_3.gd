extends Node3D

func climb():
	visible = true
	$AnimationPlayer.play("ClimbFromHell")
	$AnimationPlayer.queue("Idle")
	
func butterflyplay():
	$AnimationPlayer.play("ButterflyGame")
	
func butterflywin():
	$AnimationPlayer.play("ButterflyGameWin")
	$AnimationPlayer.queue("Idle")

func idle():
	$AnimationPlayer.play("Idle")
