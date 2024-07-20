shader_type canvas_item;

uniform float scanline_size : hint_range(1.0, 4.0) = 2.0;
uniform float distortion_amount = 0.0;
uniform float time_speed : hint_range(0.0, 10.0) = 0.5;
uniform float brightness : hint_range(0.0, 2.0) = 1.3; // Adicionando controle de brilho

void fragment() {
    vec2 resolution = vec2(textureSize(TEXTURE, 0));
    vec2 uv = FRAGCOORD.xy / resolution;
    
    // Calculate time-based distortion
    float time = TIME * time_speed;
	//float time = time_speed;
    
    // Simulate scanlines
    float scanline = sin((uv.y + time) * resolution.y * scanline_size) * 0.5 + 0.5;

    // Apply CRT distortion
    uv.x += distortion_amount * sin((uv.y + time) * 3.14159265 * 2.0);
    uv.y += distortion_amount * sin((uv.x + time) * 3.14159265 * 2.0);

    vec4 color = texture(TEXTURE, uv);
    
    // Apply scanline effect to the color
    color.rgb *= scanline;

    // Ajuste de brilho
    color.rgb *= brightness;

    COLOR = color;
}
