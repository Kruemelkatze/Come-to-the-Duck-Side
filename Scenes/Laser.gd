extends RayCast2D

var viewport_size = Vector2()
export var color = 1

export var number = 1
export var collision_point = Vector2()
export var colliding = false
export var is_combined = false

func _ready():
	viewport_size = get_viewport_rect().size
	cast_to = Vector2(viewport_size.length(), 0)
	$Sprite.texture.flags = $Sprite.texture.flags | $Sprite.texture.FLAG_REPEAT
		
func set_number(num: int):
	number = num
	$Area2D.set_collision_layer_bit(num, true)
	set_collision_mask_bit(3 - num, true)
	
func disable_line():
	$Area2D/CollisionShape2D.disabled = true
	$Area2D.collision_mask = 1
	$Area2D.collision_layer = 0

func _process(delta):
	var cast_length = cast_to.x
	
	colliding = is_colliding()
	if colliding:
		collision_point = get_collision_point ()
		var collider = get_collider()
		var p = to_local(collision_point)
		$Sprite.position.x = p.x / 2
		$Sprite.region_rect.size.x = p.x
		$Area2D/CollisionShape2D.shape.b.x = p.x + 1
		$HitTest.position.x = $Area2D/CollisionShape2D.shape.b.x
		$HitTest.visible = true
		print_debug(str(number) + "  " + str(collision_point.x))
	else:
		$Sprite.position.x = cast_length / 2;
		$Sprite.region_rect.size.x = cast_length
		$Area2D/CollisionShape2D.shape.b.x = cast_length
		$HitTest.visible = false