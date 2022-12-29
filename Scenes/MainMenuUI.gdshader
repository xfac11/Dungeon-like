shader_type canvas_item;
void fragment()
{
	COLOR = texture(TEXTURE,UV + sin(0.1*TIME));
}