class_name Page
extends Node3D

var default_color: Color
var tween: Tween
@onready var rune_sprite := $PageMesh/Rune

func _ready() -> void:
	default_color = rune_sprite.modulate

func set_rune(rune: Rune) -> void:
	rune_sprite.texture = rune.texture

func glow_start():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(rune_sprite, "modulate", Color.PINK, 0.1)

func glow_finish():
	if rune_sprite.modulate.is_equal_approx(default_color):
		return
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(rune_sprite, "modulate", default_color, 0.1)

func pulse():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(rune_sprite, "modulate", Color.CRIMSON, 0.1)
	tween.tween_property(rune_sprite, "modulate", default_color, 0.1)
	
