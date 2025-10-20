extends Control
var vidratio
var vsize
func _ready() -> void:
	var player = $AspectRatioContainer/VideoStreamPlayer
	var texture = player.get_video_texture()
	var size = texture.get_size()
	vsize = size
	vidratio = size.x/size.y
	
