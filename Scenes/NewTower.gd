extends Node2D

export var angular_speed = 90
export var player_number = 1
var wasd = false

export var colorName = 'red'

func _ready():
	angular_speed = deg2rad(angular_speed)
	
	$NewLaser.change_color(colorName)
	$RaptorSprite/ColorIndicator.modulate = Globals.get_color_by_name(colorName)
	
	set_player_number(player_number)	
	
func set_player_number(number):
	if number < 0 || number > 2:
		number = 0
	player_number = number
	wasd = player_number == 2
	$NewLaser.set_active(number != 0)
	
func _process(delta):
	if player_number == 0:
		return
		
	var direction = Vector2.ZERO
	if wasd && Input.is_key_pressed(KEY_D) || !wasd && Input.is_action_pressed("ui_right"):
		direction.x += 1
	if wasd && Input.is_key_pressed(KEY_A) || !wasd && Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if wasd && Input.is_key_pressed(KEY_W) || !wasd && Input.is_action_pressed("ui_up"):
		direction.y -=1
	if wasd && Input.is_key_pressed(KEY_S) || !wasd && Input.is_action_pressed("ui_down"):
		direction.y +=1
	
	if direction.length_squared() != 0:
		var target_angle = direction.angle()
		var diff_1 = fposmod(target_angle - rotation, 2 * PI)
		var diff_2 = fposmod(rotation - target_angle, 2 * PI)

		if diff_1 < diff_2:
			rotation += min(diff_1, delta * angular_speed)
		else:
			rotation -= min(diff_2, delta * angular_speed)