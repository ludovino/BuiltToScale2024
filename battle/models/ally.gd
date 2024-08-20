class_name Ally

extends Node3D

@export var materials: Array[StandardMaterial3D]
func die() -> void:
	for mat in materials:
		var tween = get_tree().create_tween()
		mat.albedo_color = Color.RED
		tween.tween_property(mat, "albedo_color", Color.TRANSPARENT, 0.7)
		
