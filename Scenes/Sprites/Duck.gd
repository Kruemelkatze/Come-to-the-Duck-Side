extends PathFollow2D

signal missed_duck

export var speed = 100
export var color = 'default'

var was_hit = false
var health = 1.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_color(color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if was_hit && health > 0:
		health = max(health - delta / Globals.DucksLifeInSeconds, 0)
		set_alpha(health)
	elif !was_hit && health < 1:
		health = min(health + delta / Globals.DucksLifeInSeconds, 1)
		set_alpha(health)

	was_hit = false

func set_color(c):
	color = c
	$DuckSprite/ColorSprite.modulate = Globals.get_color_by_name(c)

func set_alpha(a):
	$DuckSprite/ColorSprite.modulate.a = a
	$DuckSprite/OutlineSprite.modulate.a = a

func kill_me():
	if health > Globals.KillDuckAtLifePoints:
		was_hit = true	
		return false
	else:
		call_deferred("queue_free")
		return true

func _on_VisibilityNotifier2D_screen_exited():
	print(get_unit_offset())
	#if(get_unit_offset()>0.8):
		#print("EMIT SIGNAL")
		#emit_signal("missed_duck")
		#call_deferred("queue_free")
func missed():
	emit_signal("missed_duck")
	call_deferred("queue_free")
