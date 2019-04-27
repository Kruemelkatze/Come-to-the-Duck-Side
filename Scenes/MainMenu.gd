extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var start_hover = false
var exit_hover = false
var hover_time = 0
var start_label
var exit_label

# Called when the node enters the scene tree for the first time.
func _ready():
	start_label = $MainMenuContainer/VBoxContainer/CenterContainer/VBoxContainer/StartGameLabel
	exit_label = $MainMenuContainer/VBoxContainer/CenterContainer/VBoxContainer/ExitGameLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_hover:
		start_label.set_rotation(PI/24 * sin(hover_time))
		hover_time += 10*delta
	if exit_hover:
		exit_label.set_rotation(PI/24 * sin(hover_time))
		hover_time += 10*delta


func _on_StartGameLabel_mouse_entered():
	start_hover = true

func _on_StartGameLabel_mouse_exited():
	start_hover = false
	hover_time = 0
	start_label.set_rotation(0)


func _on_ExitGameLabel_mouse_entered():
	exit_hover = true


func _on_ExitGameLabel_mouse_exited():
	exit_hover = false
	hover_time = 0
	exit_label.set_rotation(0)
