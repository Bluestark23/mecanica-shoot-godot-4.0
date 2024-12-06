extends CharacterBody2D

@export var ice : PackedScene  # Exportamos la escena
#PackedScene: Es una representación de una escena que ha sido empaquetada y guardada. Te permite cargarla e instanciarla dinámicamente en el juego.

var velocidad  = 200# Usamos "velocidad" para la velocidad en unidades por segundo
#var velocity = Vector2.ZERO # Usamos "velocity" para representar la velocidad en x e y.

func _ready():
	$AnimatedSprite2D.play("static")
	#$AnimatedSprite2D.playing = true

func _process(_delta):
	if Input.is_action_pressed("accion"):
		shootIce()
	move()
	move_and_slide()

func move():
	velocity = Vector2.ZERO
	#if Input.is_action_pressed('derecha'):
	#	velocity.x += 1
	#if Input.is_action_pressed('izquierda'):
	#	velocity.x -= 1
	if Input.is_action_pressed('derecha'):
		velocity.x -= 1
	if Input.is_action_pressed('izquierda'):
		velocity.x += 1
	if Input.is_action_pressed('arriba'):
		velocity.y += 1
	if Input.is_action_pressed('abajo'):
		velocity.y -= 1
	
	if velocity.y != 0 or velocity.x != 0:
		$AnimatedSprite2D.play("run")
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
	elif velocity.y == 0 and velocity.x == 0:
		$AnimatedSprite2D.play("static")
	
	velocity = velocity.normalized() * velocidad

func shootIce():
	var shoot_ice = ice.instantiate()
	if $AnimatedSprite2D.flip_h:
		$Shoot.scale.x = -1
		shoot_ice.scale = Vector2(-2.3,2.3)
		shoot_ice.velocidad = -320
	else:
		$Shoot.scale.x = 1
		shoot_ice.scale = Vector2(2.3,2.3)
		shoot_ice.velocidad = 320
	shoot_ice.global_position = $Shoot/Direction.global_position
	get_tree().call_group("Mundo","add_child",shoot_ice)
