extends Node2D

var url = "https://nextcloud.digital-rhizome.net/public.php/dav/files/sMYpzwQksAW9itC/department_logo.png"

func _ready():
	# Create an HTTP request node and connect its completion signal.
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	# Perform a GET request. The URL below returns JSON as of writing.
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")


# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	print(type_string(typeof(body)))
	var im = Image.new()
	im.load_png_from_buffer(body)
	print(im)
	print(im.get_height(),im.get_width())
	var im_text = ImageTexture.new()
	im_text.set_image(im)
	print(im_text)
	$Sprite2D.set_texture(im_text)
	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	#print(headers)
	#print(body)
