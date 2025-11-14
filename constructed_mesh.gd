extends Node3D
@onready var fps = $Character
var vid_scene = preload("res://video.tscn")
var anchors =[]
var vmat

func _ready() -> void:
	vmat = StandardMaterial3D.new()
	
	
	# automated placements
func reset():
	for node in get_children():
		node.queue_free()
	anchors = []
	vmat = StandardMaterial3D.new()
func place_object(coord):
	var cube = MeshInstance3D.new()
	cube.mesh = BoxMesh.new()
	cube.scale =Vector3(.1,.1,.1)
	cube.position = coord
	var mat = StandardMaterial3D.new()
	cube.mesh.material = mat
	#mat.albedo_color = Color(1,0,0,1)
	add_child(cube)
	anchors.push_back(cube)
	if anchors.size()==4:
		print("adding viewport")
		#add_viewport()
		add_transparent_material()
		print("making plane")
		make_plane()
		
func add_transparent_material():
	#
	var image_texture = load("res://icon.svg")
	vmat.albedo_texture = image_texture
	vmat.albedo_color = Color(1,1,1,.5)
	vmat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	vmat.cull_mode = BaseMaterial3D.CULL_DISABLED
	
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
	
	
	
	var first_tri = [
		anchors[0].position,
		anchors[1].position,
		anchors[2].position
	]
	
	
	
	for a in first_tri:
		vertices.push_back(a)
	# use the first and third plus a new point to make the second triangle for the plane
	
	var second_tri = [
		anchors[0].position,
		anchors[2].position,
		anchors[3].position
	]
	for a in second_tri:
		vertices.push_back(a)
		
	var uvs = PackedVector2Array()
	uvs.push_back(Vector2(0,0))# 0
	uvs.push_back(Vector2(0,1))# 1
	uvs.push_back(Vector2(1,1))# 2
	#
	uvs.push_back(Vector2(0,0)) #0
	uvs.push_back(Vector2(1,1)) #2
	uvs.push_back(Vector2(1,0))#3

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
	


			
