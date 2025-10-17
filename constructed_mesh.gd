extends Node3D
@onready var fps = $Character
var anchors =[]
func place_object(coord):
	var cube = MeshInstance3D.new()
	cube.mesh = BoxMesh.new()
	cube.position = coord
	var mat = StandardMaterial3D.new()
	cube.mesh.material = mat
	add_child(cube)
	anchors.push_back(cube)
	if anchors.size()==3:
		make_plane()

func make_plane():
	# use the immediate mesh option
	var custom_plane = MeshInstance3D.new()
	var mat = StandardMaterial3D.new()
	var mesh = ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES,mat)
	for a in anchors:
		mesh.surface_add_vertex(a.position)
	# use the first and third plus a new point to make the second triangle for the plane
	var new_pos = Vector3(anchors[0].position.x,anchors[2].position.y,anchors[0].position.z)
	var second_tri = [
		anchors[2].position,
		new_pos,
		anchors[0].position
	]
	for a in second_tri:
		mesh.surface_add_vertex(a)
	mesh.surface_end()
	custom_plane.mesh = mesh
	add_child(custom_plane)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("pressed")
			var pos = Vector3(fps.position)
			if anchors.size()==2:
				pos = Vector3(anchors[1].position)
				pos.y+=2
			place_object(pos)
			
