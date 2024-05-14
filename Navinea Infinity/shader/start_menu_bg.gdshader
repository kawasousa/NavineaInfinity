shader_type canvas_item;

uniform float vel = - .025f;

void fragment(){
	COLOR = texture(TEXTURE, UV + vec2(-1, 0) * TIME * vel);
}
