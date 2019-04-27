extends CanvasLayer

signal game_over

var lifes = 3
var continue_select = false
var mainmenu_select = false
var hover_time = 0

func _ready():
	$PauseScreen.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if not get_tree().paused:
			get_tree().paused = true
			$PauseScreen.show()
			$PauseScreen/CenterContainer/VBoxContainer/ContinueLabel.grab_focus()
		else:
			get_tree().paused = false
			$PauseScreen.hide()
	if continue_select:
		$PauseScreen/CenterContainer/VBoxContainer/ContinueLabel.set_rotation(PI/24 * sin(hover_time))
		hover_time += 10*delta
	if mainmenu_select:
		$PauseScreen/CenterContainer/VBoxContainer/ReturnMainLabel.set_rotation(PI/24 * sin(hover_time))
		hover_time += 10*delta

func ContinueLabel_emph_start():
	continue_select = true
	
func ContinueLabel_emph_stop():
	continue_select = false
	hover_time = 0
	$PauseScreen/CenterContainer/VBoxContainer/ContinueLabel.set_rotation(0)
	
func ReturnMainLabel_emph_start():
	mainmenu_select = true
	
func ReturnMainLabel_emph_stop():
	mainmenu_select = false
	hover_time = 0
	$PauseScreen/CenterContainer/VBoxContainer/ReturnMainLabel.set_rotation(0)

func _on_ReturnMainLabel_gui_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
		get_tree().paused = false

func _on_ContinueLabel_gui_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().paused = false
		$PauseScreen.hide()
