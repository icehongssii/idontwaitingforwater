extends Node2D


var score = 0 
var file_path = "user://high_score.save"
var high_scores = []
var max_scores = 10
var is_play = true
var made_faster = false
signal make_faster()


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = 0.3	
	$Timer.start()
	$CanvasLayer/button.visible = false
	$CanvasLayer/nicknameText.visible = false
	$CanvasLayer/ranks.visible = false
	$CanvasLayer/playbutton.visible = false
	load_high_scores()

func get_high_scores():
	return high_scores
	
# Called every frame. 'delta' is the elapsed time since the previous frame.




func _process(delta):
	if score % 100 == 0 and score > 5:
		if not made_faster:
			var player = $Player
			player.SPEED += player.SPEED * 0.2
			made_faster = true
			print(get_node("Player").SPEED, '<<')
	else:
		made_faster = false

	
func sort_scores(a, b):
	return a.score > b.score  # Assuming 'score' is the key you want to sort by.

func update_scores():
	var display_text = "Top 5 Scores:\n"
	for i in range(min(high_scores.size(), 5)):
		display_text += str(i + 1) + ". " + high_scores[i].name + ": " + str(high_scores[i].score) + "\n"
	$CanvasLayer/ranks.set_text(display_text)

func _on_timer_timeout():
	score +=1  
	$CanvasLayer/Score.text = str(score) +" score"


func load_high_scores():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path,FileAccess.READ)
		high_scores = file.get_var()
		print(high_scores)
	else:
		high_scores = []
		
func add_score(nickname, score):
	high_scores.append({"name": nickname, "score": score})
	high_scores.sort_custom(Callable(self, "sort_scores"))
	if high_scores.size() > max_scores:
		high_scores.resize(max_scores)
	save_score()

	
func save_score():
	var file = FileAccess.open(file_path,FileAccess.WRITE)
	file.store_var(high_scores)
	file.close()

	

func _on_player_game_over():
	$Timer.stop()
	$playmusic.stop()
	$deathmusic.play()
	$CanvasLayer/button.visible = true
	$CanvasLayer/nicknameText.visible = true


func _on_button_pressed():
	var id = str($CanvasLayer/nicknameText.get_text())
	add_score(id, score)
	$CanvasLayer/Score.visible = false
	$CanvasLayer/button.visible = false
	$CanvasLayer/nicknameText.visible = false
	$CanvasLayer/ranks.visible = true
	$CanvasLayer/playbutton.visible = true
	update_scores()
	is_play = false
	
	


func _on_playbutton_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
