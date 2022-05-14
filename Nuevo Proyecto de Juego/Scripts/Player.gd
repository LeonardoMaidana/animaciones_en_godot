extends KinematicBody2D

#constantes
const moveSpeed = 120
const maxSpeed = 140

const jumpHeight = -500
const limitJump = -800
const up = Vector2(0,-1)
const gravity = 15

#variables
var velocity = Vector2(0,-1)
var jumps = 0
var jumpsMax = 2
var jumpDouble = -400


func _physics_process(delta):
	move()
	jump()
	velocity = move_and_slide(velocity, Vector2(0,-1))
	velocity.y += gravity
func move():
	if Input.is_action_pressed("ui_right"):
		if jumps == 0:
			$SpritePJ.play("Run")
			$SpritePJ.flip_h = false
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)
	elif Input.is_action_pressed("ui_left"):
		if jumps == 0:
			$SpritePJ.play("Run")
			$SpritePJ.flip_h = true
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
	else:
		velocity.x = 0
	if velocity.x == 0 and jumps == 0:
		$SpritePJ.play("Idle")
	if Input.is_action_pressed("ui_down"):
		$SpritePJ.play("danio")
	if Input.is_action_just_released("ui_right") and Input.is_action_just_released("ui_left") and Input.is_action_just_released("ui_down"):
		velocity.x = 0
	pass
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



