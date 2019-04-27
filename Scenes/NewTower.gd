extends Node2D

export var angular_speed = 90
export var number = 1
var wasd = false

export var colorName = 'red'

func _ready():
	angular_speed = deg2rad(angular_speed)
	#$NewLaser.set_number(number)
	wasd = number == 2
	$NewLaser.change_color(colorName)
		
func _process(delta):
	if wasd && Input.is_key_pressed(KEY_D) || !wasd && Input.is_action_pressed("ui_right"):
		rotate(angular_speed*delta)
	if wasd && Input.is_key_pressed(KEY_A) || !wasd && Input.is_action_pressed("ui_left"):
		rotate(-angular_speed*delta)
	#if wasd && Input.is_key_pressed(KEY_W) || !wasd && Input.is_action_just_pressed("ui_up"):
	#	$NewLaser.color += 1
