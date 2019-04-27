extends Node2D

export (PackedScene) var NewLaser
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var frame = 0
var combined : Area2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frame += 1
	var l1 = $NewTower1/NewLaser
	var l2 = $NewTower2/NewLaser
	
	var l1_combination_suitable = is_suitable_for_combination(l1)
	var l2_combination_suitable = is_suitable_for_combination(l2)
	
	if l1_combination_suitable && l2_combination_suitable:
		combine_laser(l1, l2)
		hit_something_with_laser(combined)
		return
	
	remove_combined()
	hit_something_with_laser(l1)
	hit_something_with_laser(l2)
		
func is_suitable_for_combination(laser: Area2D):
	if !laser.is_colliding_with_laser:
		return false
		
	var pos = laser.global_position
	var lcp = laser.laser_collision_point
	var tcp = laser.target_collision_point
	var distance_to_laser = pos.distance_squared_to(lcp)
	var distance_to_target = pos.distance_squared_to(tcp)
	
	return distance_to_laser < distance_to_target
	
func remove_combined():
	if combined == null:
		return
		
	combined.queue_free()
	combined = null
		
func combine_laser(l1, l2):
	l1.set_to_position(l1.laser_collision_point)
	l2.set_to_position(l2.laser_collision_point)
	
	if combined == null:
		combined = NewLaser.instance(true)
		combined.is_combined = true
		add_child(combined)
	
	var color= Globals.get_combined_color(l1.colorName, l2.colorName)
	combined.change_color(color)
	combined.position = to_local(l1.laser_collision_point)
	var rot = (Vector2.ONE.rotated(l1.get_parent().rotation) + Vector2.ONE.rotated(l2.get_parent().rotation)).angle()
	combined.rotation = rot - PI / 4

func hit_something_with_laser(laser):
	if laser.is_colliding_with_target:
		laser.set_to_position(laser.target_collision_point)
		var wr = weakref(laser.get_hit_target())
		
		if wr == null:
			return
			
		var target: Area2D = wr.get_ref()
		
		if target == null || !target:
			return
		
		if target.get('color') == null:
			target = target.get_parent()
			
		if target != null && target.get('color') == laser.colorName && target.has_method('kill_me'):
			if target.kill_me():
				laser.remove_hit_target()
				target = null

	else:
		laser.set_open()
	