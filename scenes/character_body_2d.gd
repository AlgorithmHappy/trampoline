extends CharacterBody2D

@export var speed: float = 40.0
@export var mass: float = 1.0
@export_enum("Brown", "Pink")
var chosen_character: String = "Brown"

var jump_velocity: float = -59500 # Es igual a saltar el tamaño de 5 plataformas de 95 pixeles de alto
var collision_jump: bool = false
var test_minimo = 1920
var test_maximo = 0
var test_colision = false
var test_brincos = 15
var is_falling = false

func _ready() -> void:
	for animated_sprite in get_children():
		if animated_sprite is AnimatedSprite2D:
			if animated_sprite.name == chosen_character:
				animated_sprite.visible = true
			else:
				animated_sprite.visible = false

func _physics_process(delta: float) -> void:
	if test_minimo > self.position.y and test_colision:
		test_minimo = self.position.y
	if test_maximo < self.position.y and test_colision:
		test_maximo = self.position.y	
	
	# Programacion de la gravedad.
	if collision_jump:
		velocity.y = jump_velocity * delta
		var animated_sprite = get_node(chosen_character)
		animated_sprite.play("jump")
		collision_jump = false
		test_brincos -= 1
		if test_brincos == 0:
			test_colision = true
	else:
		velocity.y += ( mass * get_gravity().y ) * delta

	# Programacion del movimiento del jugador
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.x -= speed
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		velocity.x += speed
	else:
		velocity.x = 0
		
	# Comprovar si esta cayendo el personaje
	is_falling = (velocity.y > 0)
		
	move_and_slide() # Funcion que hace que el jugador se pueda mover
