extends Node2D

export (PackedScene) var Laser

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var combined: RayCast2D = null
var laser1: RayCast2D
var laser2: RayCast2D
var area1: Area2D
var area2: Area2D
var shape1: CollisionShape2D
var shape2: CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_lasers(l1: RayCast2D, l2: RayCast2D):
	laser1 = l1
	laser2 = l2
	area1 = laser1.get_node("Area2D")
	area2 = laser2.get_node("Area2D")
	shape1 = area1.get_node("CollisionShape2D")
	shape2 = area2.get_node("CollisionShape2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if laser1 == null || laser2 == null:
		return
		
	var laserActive = false
	
	var c1 = laser1.colliding
	var c2 = laser2.colliding
		
	if c1 && c2:
		var p1 = laser1.collision_point
		var p2 = laser2.collision_point
				
		var col1 = laser1.get_collider()	
		var col2 = laser2.get_collider()
		var x1 = shape1.shape.b.x
		var x2 = shape2.shape.b.x

		if col1 == area2 && col2 == area1:
			if combined == null:
				combined = Laser.instance()
				combined.set_collision_mask_bit(1, false)
				combined.set_collision_mask_bit(2, false)
				combined.disable_line()
				combined.is_combined = true
				add_child(combined)
				
			combined.position = p1
			combined.rotation = get_combined_cast_to()
			var test = Vector2(1, 0)
			test.rotated(combined.rotation)
			combined.position += test * 20
			laserActive = true
	
	if !laserActive && combined != null:
		combined.queue_free()
		combined = null

func get_combined_cast_to():
	var r1 = laser1.get_global_transform().get_rotation()
	var r2 = laser2.get_global_transform().get_rotation()
	return (r1 + r2) / 2