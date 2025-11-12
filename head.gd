extends Node3D
const RAY_LENGTH = 1000.0
var from
var to
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera3d = $Camera
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH



func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to,0xFFFFFFFF, [self])
	var result = space_state.intersect_ray(query)
