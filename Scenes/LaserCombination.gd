extends Node2D

export (PackedScene) var Laser

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var combined: RayCast2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var laserActive = false
	
	if combined != null:
		combined.set_collision_mask_bit(1, false)
		combined.set_collision_mask_bit(2, false)
			
	if $Laser1.colliding && $Laser2.colliding:
		var p1 = $Laser1.collision_point
		var p2 = $Laser2.collision_point
				
		var col1 = $Laser1.get_collider()	
		if col1 == $Laser2/Area2D:
			if combined == null:
				combined = Laser.instance()
				add_child(combined)
			combined.position = p1
			combined.rotation = get_combined_cast_to()
			laserActive = true
	
	if !laserActive && combined != null:
		combined.queue_free()
		combined = null

func get_combined_cast_to():
	return ($Laser1.rotation + $Laser2.rotation) / 2