extends Node3D
@onready var fps = $Character
var vid_scene = preload("res://video.tscn")
var anchors =[]
var vmat

func _ready() -> void:
	vmat = StandardMaterial3D.new()
	
	
	# automated placements
	
func place_object(coord):
	var cube = MeshInstance3D.new()
	cube.mesh = BoxMesh.new()
	cube.scale =Vector3(.1,.1,.1)
	cube.position = coord
	var mat = StandardMaterial3D.new()
	cube.mesh.material = mat
	add_child(cube)
	anchors.push_back(cube)
	if anchors.size()==3:
		print("adding viewport")
		add_viewport()
		print("making plane")
		make_plane()
		

func add_viewport():

	vmat.resource_local_to_scene = true
	var viewport = SubViewport.new()
	add_child(viewport)
	var vid_instance = vid_scene.instantiate()
	viewport.add_child(vid_instance)
	
	vmat.albedo_texture = viewport.get_texture()
	# update the size of the subviewport
	print("video ratio",vid_instance.vidratio)
	var viewport_height = 256
	viewport.size = Vector2(vid_instance.vidratio*viewport_height,viewport_height)
		
	
	
var videomesh
func make_plane():
	# use the immediate mesh option
	var custom_plane = MeshInstance3D.new()
	
	var vertices = PackedVector3Array()
	
	# maek a collection of vertices that are ok for a plane
	#vertices.push_back(Vector3(0,0,0))
	#vertices.push_back(Vector3(1,0,0))
	#vertices.push_back(Vector3(0,1,0))
	#
	#vertices.push_back(Vector3(1,0,0))
	#vertices.push_back(Vector3(1,1,0))
	#vertices.push_back(Vector3(0,1,0))
	#
	
	
	
	
	
	for a in anchors:
		vertices.push_back(a.position)
		print(a.position)
	# use the first and third plus a new point to make the second triangle for the plane
	var new_pos = Vector3(anchors[1].position.x,anchors[2].position.y,anchors[1].position.z)
	var second_tri = [
		anchors[1].position,
		new_pos,
		anchors[2].position
	]
	for a in second_tri:
		vertices.push_back(a)
		
	var uvs = PackedVector2Array()
	uvs.push_back(Vector2(0,1))
	uvs.push_back(Vector2(1,1))
	uvs.push_back(Vector2(0,0))
	#
	uvs.push_back(Vector2(1,1))
	uvs.push_back(Vector2(1,0))
	uvs.push_back(Vector2(0,0))

	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	print(arrays)
# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	arr_mesh.surface_set_material(0,vmat)
	custom_plane.mesh = arr_mesh
	add_child(custom_plane)
	videomesh = arr_mesh
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("pressed")
			var pos = Vector3(fps.position)
			if anchors.size()==2:
				pos = Vector3(anchors[0].position)
				pos.y+=2
			place_object(pos)
			
