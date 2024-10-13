extends CharacterBody2D

signal shoot(projectile, direction, location)

const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const PLAYER_HEIGHT_STANDING = 25
const PLAYER_HEIGHT_CROUCHING = 15

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var projectile = "spear"
var Spear = preload("res://scenes/spear.tscn")

var isThrowing = false
var crouching = false

func finishThrow() -> void:
	print("finishThrow")
	isThrowing = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Check if crouching
	crouching = Input.is_action_pressed("crouch")

 	# Get direction of input
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0: 
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	
	if Input.is_action_just_pressed("attack") && !isThrowing:
		isThrowing = true
		var throwHeight = 0
		
		if(crouching):
			animation_player.play("crouch_throw_armor")
			throwHeight = PLAYER_HEIGHT_CROUCHING
		else: 
			animation_player.play("throw_armor")
			throwHeight = PLAYER_HEIGHT_STANDING
		
		if projectile == 'spear':
			# Gotta pass the flip_h becuase if player is standing still need the direciton we are facing
			var projectileDirection = 1
			if animated_sprite.flip_h:
				projectileDirection = -1
			
			shoot.emit(Spear, projectileDirection, Vector2(position.x, position.y - throwHeight))

	if(!isThrowing):
		if is_on_floor():
			if crouching:
				animated_sprite.play("crouch_armor")
			elif direction == 0:
				animated_sprite.play("idle_armor")
			else:
				animated_sprite.play("run_armor")
		else:
			animated_sprite.play("jump_armor")
	
	if crouching:
		velocity.x = 0
	elif direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		

	move_and_slide()
