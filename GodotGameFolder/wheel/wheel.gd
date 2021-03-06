extends AnimatedSprite

var rot = 0
var rot_speed = 10
func _ready():
	set_process_input(true)
	$AddWind.connect("timeout", self, "_on_add_variance")
	$AddWind.start()

func _process(delta):
	$rotator.rotation_degrees = rot * 360 / 16
	signal_emitter.emit_signal("add_to_plane_rotation", -$rotator.rotation, delta)
	if sign(rot) == -1:
		frame = 16 - (int(rot / -1) % 16)
	else:
		frame = int(rot ) % 16


func _on_left_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				rot -= 1


func _on_right_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				rot += 1

func _on_add_variance():
	if rot > 0:
		rot += 1
	elif rot < 0:
		rot -= 1
	elif rot == 0:
		if randi()%2 == 0:
			rot += 1
		else:
			rot -= 1
	$AddWind.start()
