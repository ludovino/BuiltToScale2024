class_name RuneBook
extends Minigame

@export var runes: Array[Rune]
@export var page_scene: PackedScene
@export var desired_ui: Array[TextureRect]
@export var deactivated_color: Color
@export var activated_color: Color
@onready var page_parent := $Book/BackCover

@export var game_anim : AnimationPlayer

var pages: Array[Page] = []
var desired: Array[int] = []
var current_page = 0
var desired_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	visible = false
	current_page = 0
	pages.clear()
	desired.clear()
	desired_index = 0
	runes.shuffle()
	for rune in runes:
		var page = page_scene.instantiate() as Page
		pages.append(page)
		page_parent.add_child(page)
		page.set_rune(rune)
		page.visible = false
	pages[0].visible = true
	
	for i in range(5):
		var rand_idx = randi_range(0, runes.size() - 1)
		desired.append(rand_idx)
		desired_ui[i].texture = runes[rand_idx].texture
	
	reset_desired()

func start() -> void:
	visible = true
	$DesiredContainer.visible = true

func enable_input() -> void:
	process_mode = PROCESS_MODE_ALWAYS

func teardown() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	visible = false
	$DesiredContainer.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("minigame_left"):
		prev_page()
	if Input.is_action_just_pressed("minigame_right"):
		next_page()
	if Input.is_action_just_pressed("minigame_button_1"):
		activate()

func next_page() -> void:
	if current_page >= runes.size() - 1:
		return
	var tween = get_tree().create_tween()
	var current = pages[current_page]
	
	tween.tween_property(current, "rotation:z", deg_to_rad(-150.0), 0.3)
	var prev: Page
	
	if current_page >= 1: 
		prev = pages[current_page - 1]
		tween.parallel()
		tween.tween_interval(0.29)
		tween.tween_callback(_hide_page.bind(prev))
		
	current_page += 1
	pages[current_page].visible = true
	print(current_page)
	
func prev_page() -> void:
	if current_page <= 0:
		return
	var next = pages[current_page]
	var current = pages[current_page - 1]
	var prev: Page
	if current_page > 1:
		prev = pages[current_page - 2]
		prev.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(current, "rotation:z", 0.0, 0.3)
	
	var hideTween = get_tree().create_tween()
	hideTween.tween_interval(0.29)
	hideTween.tween_callback(_hide_page.bind(next))
	
	current_page -= 1
	print(current_page)
	
func activate() -> void:
	print(current_page)
	if current_page != desired[desired_index]:
		reset_desired()
		desired_index = 0
		$RuneSelect.pitch_scale = 0.9
		$RuneSelect.play()
		return
	if current_page == desired[desired_index]:
		var tween = get_tree().create_tween()
		var ui_el = desired_ui[desired_index]
		ui_el.modulate = Color.WHITE
		ui_el.scale = Vector2.ONE * 1.2
		tween.tween_property(ui_el, "modulate", activated_color, 0.1)
		tween.parallel()
		tween.tween_property(ui_el, "scale", Vector2.ONE, 0.1)
		$RuneSelect.pitch_scale = 1 + desired_index * 0.2
		$RuneSelect.play()
	if desired_index == desired.size() - 1:
		process_mode = ProcessMode.PROCESS_MODE_DISABLED
		succeeded.emit()
	desired_index += 1

func reset_desired():
	for rect in desired_ui:
		rect.modulate = deactivated_color

func _hide_page(page: Page) -> void:
	page.visible = false
