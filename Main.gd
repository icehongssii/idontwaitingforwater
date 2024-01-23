extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# now I want to make it in random 
	pass
	
	
	


func _on_hud_start_game():
	
	$CPUParticles2D.visible = false
	print("button clicked")


func _on_cpu_particles_2d_finished():
	pass # Replace with function body.
