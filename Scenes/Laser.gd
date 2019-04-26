extends RayCast2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var viewport_size = Vector2()
export var angular_speed = 45
var color = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport_size = get_viewport_rect().size
	cast_to = Vector2(viewport_size.length(), 0)
	angular_speed = deg2rad(angular_speed)
	$Sprite.texture.flags = $Sprite.texture.flags | $Sprite.texture.FLAG_REPEAT
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var cast_length = cast_to.x
	
	if Input.is_action_pressed("ui_right"):
		rotate(angular_speed*delta)
	if Input.is_action_pressed("ui_left"):
		rotate(-angular_speed*delta)
	if Input.is_action_just_pressed("ui_up"):
		color += 1
		$Sprite.modulate = Color(1 if color & 4 else 0, 1 if color & 2 else 0, 1 if color & 1 else 0)
		
	if is_colliding():
		$HitTest.visible = true
		var p = get_collision_point ()
		p = to_local(p)
		$HitTest.position = p
		$Sprite.position.x = p.x / 2
		$Sprite.region_rect.size.x = p.x
	else:
		$Sprite.position.x = cast_length / 2;
		$Sprite.region_rect.size.x = cast_length
		$HitTest.visible = false		
	

