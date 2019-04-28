extends Node2D

export (PackedScene) var NewLaser
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var frame = 0
var combined : Area2D = null

export var TowerPlayer1: NodePath
export var TowerPlayer2: NodePath

var towers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	towers = get_children()
	if TowerPlayer1.is_empty():
		TowerPlayer1 = get_path_to(towers[0])
	if TowerPlayer2.is_empty():
		TowerPlayer2 = get_path_to(towers[1])
		
	var t1 = get_node(TowerPlayer1)
	t1.set_player_number(1)
	var t2 = get_node(TowerPlayer2)
	t2.set_player_number(2)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_switch_towers()
	
	frame += 1
	var t1 = get_node(TowerPlayer1)
	var l1 = t1.get_node('NewLaser')
	var t2 = get_node(TowerPlayer2)
	var l2 = t2.get_node('NewLaser')
	
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
	
func check_switch_towers():
		if Input.is_action_just_pressed("switch_color_1"):
			var t = switch_player(1)
			TowerPlayer1 = get_path_to(t)
		if Input.is_action_just_pressed("switch_color_2"):
			var t = switch_player(2)
			TowerPlayer2 = get_path_to(t)
			
func switch_player(player):
	var length = towers.size()
	var current = -1
	for i in range(length):
		var t = towers[i]
		if t.player_number == player:
			current = i
			break
			
	var current_tower = towers[current]
	
	var nextFree = current
	for i in range(length):
		var j = (current + i) % length
		var t = towers[j]
		if t.player_number == 0:
			current_tower.set_player_number(0)
			t.set_player_number(player)
			return t
			
	return current_tower