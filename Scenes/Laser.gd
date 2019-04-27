extends RayCast2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var viewport_size = Vector2()
export var angular_speed = 45
var color = 1
export var wasd = false;
export var nomove = false;

export var collision_point = Vector2()
export var colliding = false

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport_size = get_viewport_rect().size
	cast_to = Vector2(viewport_size.length(), 0)
	angular_speed = deg2rad(angular_speed)
	$Sprite.texture.flags = $Sprite.texture.flags | $Sprite.texture.FLAG_REPEAT
	$Area2D.set_collision_layer_bit(1 if wasd else 2, true)
	set_collision_mask_bit(2 if wasd else 1, true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var cast_length = cast_to.x
	
	if !nomove:
		if wasd && Input.is_key_pressed(KEY_D) || !wasd && Input.is_action_pressed("ui_right"):
			rotate(angular_speed*delta)
		if wasd && Input.is_key_pressed(KEY_A) || !wasd && Input.is_action_pressed("ui_left"):
			rotate(-angular_speed*delta)
		if wasd && Input.is_key_pressed(KEY_W) || !wasd && Input.is_action_just_pressed("ui_up"):
			color += 1
			$Sprite.modulate = Color(1 if color & 4 else 0, 1 if color & 2 else 0, 1 if color & 1 else 0)
		
	colliding = is_colliding()
	if colliding:
		#$HitTest.visible = true
		collision_point = get_collision_point ()
		var p = to_local(collision_point)

		#$HitTest.position = p
		$Sprite.position.x = p.x / 2
		$Sprite.region_rect.size.x = p.x
	else:
		$Sprite.position.x = cast_length / 2;
		$Sprite.region_rect.size.x = cast_length
		#$HitTest.visible = false	
