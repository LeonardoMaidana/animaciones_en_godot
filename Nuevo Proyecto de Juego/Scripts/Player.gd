extends KinematicBody2D

#constantes
const moveSpeed = 120
const maxSpeed = 140

const jumpHeight = -400
const limitJump = -800
const up = Vector2(0,-1)
const gravity = 15

#variables
var velocity = Vector2(0,-1)
var jumps = 0
var jumpsMax = 2
var jumpDouble = -300
#implementacion de animaciones
onready var animationPlayer = get_node("AnimationPlayer")


func _physics_process(delta):
	#gravedad y friccion
	move()
	jump()
	velocity = move_and_slide(velocity, Vector2(0,-1))
	velocity.y += gravity
	#idle
func move():
	if Input.is_action_pressed("ui_right"):
		
		$SpritePJ.flip_h = false
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)
		
	elif Input.is_action_pressed("ui_left"):
		
		$SpritePJ.flip_h = true
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
		
	else:
		velocity.x = 0
	if velocity.x == 0 and jumps == 0:
		$SpritePJ.play("Idle")
	elif velocity.x > 0 or velocity.x < 0 and jumps == 0:
		$SpritePJ.play("Run")
		
	#si esta en el piso puede saltar(tambien doble salto)
	
func jump():
	if is_on_floor():
		jumps = 0
	if Input.is_action_just_pressed("ui_up") and jumps == 0:
		velocity.y = +jumpHeight
		jumps += 1
		$SpritePJ.play("Jumping")
	else:
		if Input.is_action_just_pressed("ui_up") and jumps == 1:
			velocity.y = +jumpDouble
			jumps += 1
			$SpritePJ.play("DobleJump")
	pass



