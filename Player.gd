extends KinematicBody2D

var velocity = Vector2.ZERO

#The initialize function
func _ready():
	pass

#Every physics frame in game
func _physics_process(delta):
	velocity.y +=2
	
	#Buttons
	if Input.is_action_pressed("ui_right"):
		velocity.x=100
	elif Input.is_action_pressed("ui_left"):
		velocity.x=-100
	else:
		velocity.x=0
		
	if Input.is_action_just_pressed("ui_up"):
		velocity.y=-100
		
	velocity = move_and_slide(velocity) #Moves character and detects collisions/Gravity
