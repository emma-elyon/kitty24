use miniquad::*;

pub const VERTEX: &str = r"#version 100
attribute vec2 pos;

uniform vec2 resolution;

varying lowp vec2 texcoord;

void main() {
	vec2 scaled_pos = vec2(
		pos.x * 640.0 / resolution.x,
		pos.y * 360.0 / resolution.y
	);
	float scale = min(resolution.x / 640.0, resolution.y / 360.0);
	scale = floor(scale) == 0.0 ? scale : floor(scale);
	gl_Position = vec4(scaled_pos.x * scale, -scaled_pos.y * scale, 0, 1);
	texcoord = pos * 0.5 + 0.5;
}";

pub const FRAGMENT: &str = r"#version 100
varying lowp vec2 texcoord;

uniform sampler2D tex;

void main() {
	gl_FragColor = texture2D(tex, texcoord);
}";

pub fn meta() -> ShaderMeta {
	ShaderMeta {
		images: vec!["tex".to_string()],
		uniforms: UniformBlockLayout {
			uniforms: vec![UniformDesc::new("resolution", UniformType::Float2)],
		},
	}
}

#[repr(C)]
pub struct Uniforms {
	pub resolution: (f32, f32),
}
