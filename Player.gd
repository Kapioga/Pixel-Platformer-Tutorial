extends KinematicBody2D

export(int) var JUMP_FORCE = -160 #Public 
export(int) var JUMP_RELEASE_FORCE = -40 
export(int) var MAX_SPEED = 75
export(int) var ACCELERATION = 10
export(int) var FRICTION = 10
export(int) var GRAVITY= 5
export(int) var ADDITIONAL_FALL= 2

var velocity = Vector2.ZERO

#The initialize function
func _ready():
	pass

#Every physics frame in game
func _physics_process(delta):
	apply_gravity()
	
	#Adds friction and movement
	var input = Vector2.ZERO
	input.x= Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x==0:
		apply_friction()
		#Calls the node for sprite
		$AnimatedSprite.animation = "idle"
	else:
		apply_acceleration(input.x)
		$AnimatedSprite.animation = "Run"
	
	#checks if player is jumping
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"): #ensures that it jumps once
			velocity.y= JUMP_FORCE
	else:
		$AnimatedSprite.animation = "Jump" 
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y= -70
		
		#Fall gravity
		if velocity.y > 0 :
			velocity.y += ADDITIONAL_FALL
	
	#Detects what fram to play when landing
	var was_in_air = is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP) #Moves character and detects collisions/Gravity
	var just_landed = is_on_floor() and not was_in_air
	
	if just_landed: #Plays frame when landed
		$AnimatedSprite.animation = "Run"
		$AnimatedSprite.frame = 1

#Gravity
func apply_gravity():
	velocity.y += GRAVITY

#Friction
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	
#Movement
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION )
