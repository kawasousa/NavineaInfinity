shader_type canvas_item;

uniform float vel = - .3f;
uniform float displacement = .0f;

void fragment(){
	COLOR = texture(TEXTURE, UV + (vec2(-1, 0) * TIME * vel) + vec2(0, displacement));
}
