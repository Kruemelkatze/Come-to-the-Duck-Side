extends CanvasLayer

signal game_over

var lifes = 3

func _ready():
	$PauseScreen.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if not get_tree().paused:
			get_tree().paused = true
			$PauseScreen.show()
		else:
			get_tree().paused = false
			$PauseScreen.hide()
