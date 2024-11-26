extends ParallaxBackground

# Velocidad del movimento
@export_range(0, 500) var scroll_speed: float = 120

# Multiplicador por cada capa del parallax
@export_range(0, 2) var scroll_layer_multiply_speed: float = 0.5

# Variables globales
var zero: int = 0
var one: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var count: int = zero
	for layer in get_children():
		if layer is ParallaxLayer:
			# Operacion que se debe hacer para el movimiento de cadacapa
			var auxiliar = Vector2((scroll_speed * (count * scroll_layer_multiply_speed) ) * delta, zero)
			layer.motion_offset += auxiliar 
			count += one # Para la capa 1 se multiplica por (1 x scroll_layer_multiply_speed), para la dos (2 x scroll_layer_multiply_speed) y asi sucesivamente
