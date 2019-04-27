extends Node2D



# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.
	var anim = get_node("Path2D/PathFollow2D/AnimationPlayer")
	if(not anim.is_playing()):
    	anim.play("DuckAnimation")
		
	if(not anim.is_playing()):
		print("not playing" )
func set_texture(texture):
	var duck_sprite = get_node("Path2D/PathFollow2D/DuckSprite")
	duck_sprite.set_texture(texture)
	#duck_sprite.rotate()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _init(duck_texture):
	#$Duck/DuckSprite.texture(duck_texture)