extends CanvasLayer

var lifes = 3
var number_of_levels = 3

var continue_select = false
var mainmenu_select = false
var restart_select = false
var next_level_select = false
var hover_time = 0
var level_ended = false

var next_level = "Level_1"

func _ready():
	$PauseScreen.hide()
	$GameOverScreen.hide()
	$SuccessScreen.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not level_ended:
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
		$SuccessScreen/CenterContainer/VBoxContainer/ReturnMainLabel.set_rotation(PI/24 * sin(hover_time))
		hover_time += 10*delta
	if restart_select:
		$GameOverScreen/CenterContainer/VBoxContainer/RestartLabel.set_rotation(PI/24 * sin(hover_time))
		$SuccessScreen/CenterContainer/VBoxContainer/RestartLabel.set_rotation(PI/24 * sin(hover_time))
		hover_time += 10*delta
	if next_level_select:
		$SuccessScreen/CenterContainer/VBoxContainer/NextLevelLabel.set_rotation(PI/24 * sin(hover_time))
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
	$SuccessScreen/CenterContainer/VBoxContainer/ReturnMainLabel.set_rotation(0)

func RestartLabel_emph_start():
	restart_select = true
	
func RestartLabel_emph_stop():
	restart_select = false
	hover_time = 0
	$GameOverScreen/CenterContainer/VBoxContainer/RestartLabel.set_rotation(0)
	$SuccessScreen/CenterContainer/VBoxContainer/RestartLabel.set_rotation(0)

func NextLevelLabel_emph_start():
	next_level_select = true
	
func NextLevelLabel_emph_stop():
	next_level_select = false
	hover_time = 0
	$SuccessScreen/CenterContainer/VBoxContainer/NextLevelLabel.set_rotation(0)


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
	level_ended = true
	$GameOverScreen.show()
	$GameOverScreen/CenterContainer/VBoxContainer/RestartLabel.grab_focus()

func _on_missed_duck():
	lifes -= 1
	update_life_counter()
	if lifes <= 0 and not level_ended and get_tree():
		get_tree().paused = true
		game_over()

func _on_RestartLabel_gui_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
		get_tree().paused = false

func _on_level_complete(level):
	get_tree().paused = true
	var success_text
	if level < number_of_levels:
		success_text = "Success in World " + str(level) + "!\n Continue to next level?"
		$SuccessScreen/CenterContainer/VBoxContainer/NextLevelLabel.grab_focus()
		next_level = "Level_" + str(level+1)
	elif level == number_of_levels:
		success_text = "Congratulations!\n You beat the game! :)"
		$SuccessScreen/CenterContainer/VBoxContainer/NextLevelLabel.hide()
		$SuccessScreen/CenterContainer/VBoxContainer/RestartLabel.grab_focus()
	
	$SuccessScreen/CenterContainer/VBoxContainer/NextLevelLabel.rect_pivot_offset = 0.5*$SuccessScreen/CenterContainer/VBoxContainer/NextLevelLabel.rect_size
	$SuccessScreen/CenterContainer/VBoxContainer/RestartLabel.rect_pivot_offset = 0.5*$SuccessScreen/CenterContainer/VBoxContainer/RestartLabel.rect_size
	$SuccessScreen/CenterContainer/VBoxContainer/ReturnMainLabel.rect_pivot_offset = 0.5*$SuccessScreen/CenterContainer/VBoxContainer/ReturnMainLabel.rect_size
	
	$SuccessScreen/CenterContainer/VBoxContainer/SuccessLabel.set_text(success_text)
	$SuccessScreen.show()


func _on_NextLevelLabel_gui_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Levels/" + next_level + ".tscn")
		get_tree().paused = false
