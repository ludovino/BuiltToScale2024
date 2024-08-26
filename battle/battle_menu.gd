extends Control

@export var white_magic_menu : Control
@export var wm_menu_focus : Control
@export var initial_focus : Control
@export var summoner_focus : Control
@export var damage_amount : float
@export var heal_amount : float
@export var heal_all_amount : float
@export var damage_interval : float
@export var health_bars : Array[ProgressBar]
@export var summoner_health_bar : ProgressBar
@export var clod_hb : ProgressBar
@export var ninja_hb: ProgressBar
@export var summoner_mana_bar : ProgressBar

@export var cure_button: Button
@export var cure_all_button : Button
@onready var timer := $Timer
enum Spell { NONE, CURE, CURE_ALL }

var selected_spell : Spell

signal summoner_died
signal wilkins_died
signal grob_died

signal lost

signal summoner_damaged
signal wilkins_damaged
signal grob_damaged

func _ready() -> void:
	timer.start(damage_interval)

func wipe() -> void:
	for hb in health_bars:
		hb.value = 0.0
		if hb == summoner_health_bar:
			summoner_died.emit()
		if hb == clod_hb:
			grob_died.emit()
		if hb == ninja_hb:
			wilkins_died.emit()
		hb.modulate = Color.RED
		timer.stop()

func kill_summoner():
	var hb = summoner_health_bar
	hb.value = 0.0
	hb.modulate = Color.RED
	timer.stop()
	
func _on_wht_mg_button_up() -> void:
	white_magic_menu.visible = not white_magic_menu.visible

func damage() -> void:
	var hb := health_bars.pick_random() as ProgressBar
	hb.value -= damage_amount
	if is_zero_approx(hb.value):
		damage_interval = damage_interval * 0.6
		if hb == summoner_health_bar:
			lost.emit()
			timer.stop()
		if hb == clod_hb:
			grob_died.emit()
		if hb == ninja_hb:
			wilkins_died.emit()
		hb.modulate = Color.RED
		return
	_check_alerts()
	flash(hb, Color.RED)
	$Damage.play()

func check_mana() -> void:
	if summoner_mana_bar.value < 7.0:
		cure_button.disabled = true
	if summoner_mana_bar.value < 18.0:
		cure_all_button.disabled = true

func click_health_bar(idx: int) -> void:
	if selected_spell == Spell.CURE_ALL:
		cure_all()
	if selected_spell == Spell.CURE:
		cure(idx, heal_amount)
	selected_spell = Spell.NONE
	check_mana()
	white_magic_menu.visible = false

func cure(idx: int, amount: float) -> void:
	summoner_mana_bar.value -= 7.0
	var hb = health_bars[idx]
	if is_zero_approx(hb.value):
		return
	hb.value += amount
	flash(hb, Color.GREEN)
	_check_alerts()
	$Heal.play()

func _check_alerts():
	var playing = false
	for hb in health_bars:
		if hb.value < hb.max_value * 0.2 and hb.value > 0.0:
			playing = true
	$Alert.playing = playing

func flash(bar: ProgressBar, color: Color) -> void:
	var tween = get_tree().create_tween()
	bar.modulate = color
	tween.tween_property(bar, "modulate", Color.WHITE, 0.3)

func cure_all() -> void:
	summoner_mana_bar.value -= 21.0
	var healed = false
	for hb in health_bars:
		if is_zero_approx(hb.value):
			continue
		healed = true
		hb.value += heal_all_amount
		flash(hb, Color.GREEN)
	_check_alerts()
	if healed:
		$HealAll.play()

func _on_timer_timeout() -> void:
	damage()
	timer.start(damage_interval)

func _on_cure_button_up() -> void:
	selected_spell = Spell.CURE
	white_magic_menu.visible = false

func _on_cure_all_button_up() -> void:
	selected_spell = Spell.CURE_ALL
	white_magic_menu.visible = false
