extends Area2D

export var colorName = 'default'
var max_cast = 0
export var active = true

export var is_colliding_with_target = false
export var is_colliding_with_laser = false
export var target_collision_point = Vector2.INF
export var laser_collision_point = Vector2.INF
var hit_target: Object = null

export var is_combined = false

func _init(combined = false):
	is_combined = combined

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_combined:
		collision_layer = 0
		collision_mask = 0
		$LaserRaycast.enabled = false
		$CollisionShape2D.disabled = true
		$Line2D.visible = false
		
	max_cast = get_viewport_rect().size.length()
	$Line2D.points[1].x = max_cast
	$TargetRaycast.cast_to = Vector2(max_cast, 0)
	$LaserRaycast.cast_to = Vector2(max_cast, 0)
	$Sprite.texture.flags = $Sprite.texture.flags | $Sprite.texture.FLAG_REPEAT
	change_color(colorName)
	set_open()
	
func set_active(active):
	self.active = active
	$LaserRaycast.enabled = active
	$TargetRaycast.enabled = active
	$CollisionShape2D.disabled = !active
	
	if active:
		set_open()
		collision_layer = 2
	else:
		set_to_length(0)
		collision_layer = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !active:
		is_colliding_with_target = false
		is_colliding_with_laser = false
		return
		
	is_colliding_with_target = $TargetRaycast.is_colliding()
	target_collision_point = $TargetRaycast.get_collision_point() if is_colliding_with_target else Vector2.INF
	hit_target = $TargetRaycast.get_collider()
	
	if !is_combined:
		is_colliding_with_laser = $LaserRaycast.is_colliding()
		laser_collision_point = $LaserRaycast.get_collision_point() if is_colliding_with_laser else Vector2.INF
		
func change_color(col: String):
	colorName = col
	$Sprite.modulate = Globals.get_color_by_name(col)

func get_hit_target():
	return hit_target
	
func remove_hit_target():
	hit_target = null
	
func set_to_position(global_position):
	var local_pos = to_local(global_position)
	var length = local_pos.length()
	set_to_length(length)
	
func set_to_length(length):
	$Sprite.position.x = length / 2
	$Sprite.region_rect.size.x = length
	
func set_open():
	$Sprite.position.x = max_cast /2
	$Sprite.region_rect.size.x = max_cast