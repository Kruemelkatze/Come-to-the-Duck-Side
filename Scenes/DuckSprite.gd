extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2(+1,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	set_process(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_position(get_position()+vel)
#	pass