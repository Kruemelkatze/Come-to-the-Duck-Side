extends Node

var start_hover = false
var exit_hover = false
var hover_time = 0
var start_label
var exit_label

# Called when the node enters the scene tree for the first time.
func _ready():
	start_label = $MainMenuContainer/VBoxContainer/CenterContainer/VBoxContainer/StartGameLabel
	start_label.grab_focus()
	StartGameLabel_emph_start()
	exit_label = $MainMenuContainer/VBoxContainer/CenterContainer/VBoxContainer/ExitGameLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_hover:
		start_label.set_rotation(PI/24 * sin(hover_time))
		hover_time += 10*delta
	if exit_hover:
		exit_label.set_rotation(PI/24 * sin(hover_time))
		hover_time += 10*delta

func StartGameLabel_emph_start():
	start_hover = true
	
func StartGameLabel_emph_stop():
	start_hover = false
	hover_time = 0
	start_label.set_rotation(0)
	
func ExitGameLabel_emph_start():
	exit_hover = true
	
func ExitGameLabel_emph_stop():
	exit_hover = false
	hover_time = 0
	exit_label.set_rotation(0)

func _on_StartGameLabel_gui_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Levels/Level1.tscn")

func _on_ExitGameLabel_gui_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().quit()
