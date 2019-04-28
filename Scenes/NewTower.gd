extends Node2D

export var angular_speed = 60
export var number = 1
var wasd = false

export var colorName = 'red'

func _ready():
	angular_speed = deg2rad(angular_speed)
	#$NewLaser.set_number(number)
	wasd = number == 2
	$NewLaser.change_color(colorName)
		
func _process(delta):
	if wasd && Input.is_key_pressed(KEY_W) || !wasd && Input.is_action_pressed("ui_up"):
		rotate(angular_speed*delta)
	if wasd && Input.is_key_pressed(KEY_S) || !wasd && Input.is_action_pressed("ui_down"):
		rotate(-angular_speed*delta)
	#if wasd && Input.is_key_pressed(KEY_W) || !wasd && Input.is_action_just_pressed("ui_up"):
	#	$NewLaser.color += 1
