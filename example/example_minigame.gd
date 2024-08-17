extends Minigame

@export var time_limit : float
@export var timer: Timer

func _ready() -> void:
	timer = $Timer
	timer.start(time_limit)

func _enter_tree() -> void:
	request_ready()

func _exit_tree() -> void:
	timer.stop()

func _on_button_pressed() -> void:
	succeeded.emit()
	
func _on_timer_timeout() -> void:
	print("time out")
	failed.emit()
