shader_type canvas_item;
const float speed = 5.0;
const float magnitude = .5;
uniform bool on = true;
void vertex() {
	// Called for every vertex the material is visible on.
	if (on) {
		vec2 position = VERTEX;
		float time = TIME ;

		float zoom = (cos(TIME*speed)+1.5) * magnitude;

		vec2 final_zoom  = vec2(zoom,zoom);
		VERTEX = position * final_zoom;
	}
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
