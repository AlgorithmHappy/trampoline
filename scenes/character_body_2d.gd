extends CharacterBody2D

@export var speed: float = 40.0
@export var jump_velocity: float = -1000.0
@export var mass: float = 1.0
@export_enum("Brown", "Pink")
var chosen_character: String = "Brown"

func _ready() -> void:
	for animated_sprite in get_children():
		if animated_sprite is AnimatedSprite2D:
			if animated_sprite.name == chosen_character:
				animated_sprite.visible = true
			else:
				animated_sprite.visible = false

func _physics_process(delta: float) -> void:
	# Programacion de la gravedad.
	if is_on_floor():
		velocity.y -= jump_velocity * delta
	else:
		velocity.y += ( mass * get_gravity().y ) * delta

	# Programacion del movimiento del jugador
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.x -= speed
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		velocity.x += speed
	else:
		velocity.x = 0

	move_and_slide() # Funcion que hace que el jugador se pueda mover
