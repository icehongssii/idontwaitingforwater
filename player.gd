extends CharacterBody2D

enum {
	RUNNING,
	JUMPING,
	FALLING
}

var state = RUNNING	
const SPEED = 40
@onready var anim = get_node("AnimationPlayer")

var jump_height: float = 20
var jump_time_to_peak: float = 0.2
var jump_time_to_descent: float = 0.4

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_descent)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1



func get_gravity():
	return jump_gravity if velocity.y > 0 else fall_gravity

func _physics_process(delta):
	
	velocity.x = SPEED
	state = RUNNING
	
	if not is_on_floor(): # 공중이라
		velocity.y += get_gravity() * delta
		
		if velocity.y < 0: 
			state = JUMPING
		else:
			state = FALLING
#
	## Handle jump.
	if Input.is_action_just_pressed("enter") and is_on_floor():		
		velocity.y = jump_velocity
		
	match state:
		RUNNING:
			anim.play("Idle")			
		JUMPING:
			anim.play("Jump")
		FALLING:
			anim.play("Fall")
			
			
	move_and_slide()
