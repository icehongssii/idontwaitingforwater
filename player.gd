extends CharacterBody2D

enum {
	RUNNING,
	JUMPING,
	FALLING, 
	HURT
}

var state = RUNNING	
var SPEED = 200 #pixel
@onready var anim = get_node("AnimationPlayer")
var made_faster = false
var jump_height: float = 15 # 최고 높이
var jump_time_to_peak: float = 0.1 # 찍는데 걸린시간
var jump_time_to_descent: float = 0.15 # 내려가는데 걸린시간
signal game_over

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_descent)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

@onready var jump_cnt: int = 0

func get_gravity():
	return jump_gravity if velocity.y > 0 else fall_gravity

func _physics_process(delta):
	#if position.x > 1035:
		#SPEED = 500
		

	velocity.x = SPEED
	
	if state != HURT:
		state = RUNNING
		
	if not is_on_floor(): # 공중이라
		velocity.y += get_gravity() * delta
		
		if velocity.y < 0: 
			state = JUMPING
		else:
			state = FALLING
	
	
	
	## Handle jump.
	if Input.is_action_just_pressed("enter") and is_on_floor():		
		
		velocity.y = jump_velocity
		jump_cnt = 1 # 착지하면 0 

	elif Input.is_action_just_pressed("enter") and !is_on_floor():
		velocity.y += jump_velocity
		state = FALLING
		jump_cnt +=1 # 공중에서 계속 엔터누르면 +=1
		
	if jump_cnt > 6 and Input.is_action_just_pressed("enter") and !is_on_floor():
		
		velocity.y = fall_gravity
		state = FALLING
		jump_cnt = 0
	#(495.043, 117.0237)<<
	#(1271.873, 117.0236)
	
		
#(865.0449, 117.023)
#(491.70977, 117.0237)<<<시

	
	match state:
		HURT:
			anim.play("Hurt")
		RUNNING:
			anim.play("Idle")
		JUMPING:
			anim.play("Jump")
		FALLING:
			anim.play("Fall")
	
	move_and_slide()

	



func _on_area_2d_body_entered(body):
	if body is CharacterBody2D and body.name != "Player":
		state = HURT # 이것만으로 부족함
		anim.play("Hurt") # 이렇게 직접해야 저장
		game_over.emit()
		set_physics_process(false)
		
	
