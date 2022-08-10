extends KinematicBody2D

export(int) var JUMP_FORCE = -130 #Public 
export(int) var JUMP_RELEASE_FORCE = -70 
export(int) var MAX_SPEED = 50
export(int) var ACCELERATION = 20
export(int) var FRICTION = 20
export(int) var GRAVITY= 4
export(int) var ADDITIONAL_FALL= 4

var velocity = Vector2.ZERO

#The initialize function
func _ready():
	pass

#Every physics frame in game
func _physics_process(delta):
	apply_gravity()
	
	#Adds friction
	var input = Vector2.ZERO
	input.x= Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x==0:
		apply_friction()
	else:
		apply_acceleration(input.x)
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"): #ensures that it jumps once
			velocity.y= JUMP_FORCE
	else: 
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y= -70
			
		if velocity.y > 0 :
			velocity.y += ADDITIONAL_FALL

	velocity = move_and_slide(velocity, Vector2.UP) #Moves character and detects collisions/Gravity

#Gravity
func apply_gravity():
	velocity.y += GRAVITY

#Friction
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	
#Movement
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION )
