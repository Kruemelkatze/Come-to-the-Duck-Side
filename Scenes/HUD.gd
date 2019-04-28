extends CanvasLayer

var lifes = 3
var continue_select = false
var mainmenu_select = false
var restart_select = false
var hover_time = 0
var game_over_flag = false

func _ready():
	$PauseScreen.hide()
	$GameOverScreen.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not game_over_flag:
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
		$GameOverScreen/CenterContainer/VBoxContainer/ReturnMainLabel.set_rotation(PI/24 * sin(hover_time))
		hover_time += 10*delta
	if restart_select:
		$GameOverScreen/CenterContainer/VBoxContainer/RestartLabel.set_rotation(PI/24 * sin(hover_time))
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
	$GameOverScreen/CenterContainer/VBoxContainer/ReturnMainLabel.set_rotation(0)

func RestartLabel_emph_start():
	restart_select = true
	
func RestartLabel_emph_stop():
	restart_select = false
	hover_time = 0
	$GameOverScreen/CenterContainer/VBoxContainer/RestartLabel.set_rotation(0)

func _on_ReturnMainLabel_gui_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
		get_tree().paused = false

func _on_ContinueLabel_gui_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().paused = false
		$PauseScreen.hide()

func update_life_counter():
	var life_textures = $LifeContainer.get_children()
	for k in range(3):
		if k < lifes:
			life_textures[2-k].show()
		else:
			life_textures[2-k].hide()

func game_over():
	game_over_flag = true
	$GameOverScreen.show()
	$GameOverScreen/CenterContainer/VBoxContainer/RestartLabel.grab_focus()

func _on_missed_duck():
	lifes -= 1
	update_life_counter()
	if lifes <= 0 and not game_over_flag and get_tree():
		get_tree().paused = true
		game_over()

func _on_RestartLabel_gui_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
		get_tree().paused = false
