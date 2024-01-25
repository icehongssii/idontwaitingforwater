extends Node2D


var score = 0 
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = 0.3
	$Timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	score +=1  
	$CanvasLayer/Label.text = str(score) +"S"
