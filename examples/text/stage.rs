use miniquad::*;

use virtual_machine::*;

use crate::shader;

pub struct Stage<F>
where
    F: FnMut([u32; 16]),
{
    pipeline: Pipeline,
    bindings: Bindings,
    virtual_machine: VirtualMachine<F>,
    display: Vec<u8>,
    last_now: f64,
    machine_total: f64,
    frame_total: f64,
    busy_total: usize,
    frames: usize,
    keys: Vec<u16>,
}

impl<F> Stage<F>
where
    F: FnMut([u32; 16]),
{
    pub fn new(context: &mut Context, virtual_machine: VirtualMachine<F>) -> Stage<F> {
        #[rustfmt::skip]
        let vertices: [[f32; 2]; 4] = [
            [-1.0, -1.0],
            [ 1.0, -1.0],
            [ 1.0,  1.0],
            [-1.0,  1.0],
        ];
        let vertex_buffer = Buffer::immutable(context, BufferType::VertexBuffer, &vertices);

        let indices: [u16; 6] = [0, 1, 2, 0, 2, 3];
        let index_buffer = Buffer::immutable(context, BufferType::IndexBuffer, &indices);

        let display: Vec<u8> = vec![0; DISPLAY_BUFFER_SIZE];
        let texture = Texture::from_rgba8(context, WIDTH_HIGH as u16, HEIGHT_HIGH as u16, &display);
        texture.set_filter(context, FilterMode::Nearest);

        let bindings = Bindings {
            vertex_buffers: vec![vertex_buffer],
            index_buffer,
            images: vec![texture],
        };

        let shader =
            Shader::new(context, shader::VERTEX, shader::FRAGMENT, shader::meta()).unwrap();

        let pipeline = Pipeline::new(
            context,
            &[BufferLayout::default()],
            &[VertexAttribute::new("pos", VertexFormat::Float2)],
            shader,
        );

        Stage {
            pipeline,
            bindings,
            virtual_machine,
            display,
            last_now: date::now(),
            machine_total: 0.0,
            frame_total: 0.0,
            busy_total: 0,
            frames: 0,
            keys: Vec::new(),
        }
    }
}

impl<F> EventHandler for Stage<F>
where
    F: FnMut([u32; 16]),
{
    fn update(&mut self, context: &mut Context) {
        let now = date::now();
        self.virtual_machine.set_keys(&self.keys);
        self.busy_total += self.virtual_machine.run(&mut self.display, None);
        // self.virtual_machine.run(&mut self.display);
        let milliseconds = (date::now() - now) * 1000.0;
        self.machine_total += milliseconds;
        let milliseconds = (date::now() - self.last_now) * 1000.0;
        self.frame_total += milliseconds;
        self.frames += 1;
        if self.frames == 60 {
            let milliseconds = self.frame_total / self.frames as f64;
            println!(
                "FRAME: {:2} FPS ({:1.3} ms) | MACHINE: {:1.3} ms ({:1.1} % busy)",
                (1000.0 / milliseconds) as u32,
                milliseconds,
                self.machine_total / self.frames as f64,
                100.0 * self.busy_total as f64 / self.frames as f64 / CYCLES_PER_FRAME as f64,
            );
            self.frame_total = 0.0;
            self.machine_total = 0.0;
            self.busy_total = 0;
            self.frames = 0;
        }
        self.last_now = date::now();
        self.bindings.images[0].update(context, self.display.as_slice());
    }

    fn draw(&mut self, context: &mut Context) {
        let (width, height) = context.screen_size();

        context.begin_default_pass(Default::default());

        context.apply_pipeline(&self.pipeline);
        context.apply_bindings(&self.bindings);
        context.apply_uniforms(&shader::Uniforms {
            resolution: (width, height),
        });
        context.draw(0, 6, 1);
        context.end_render_pass();

        context.commit_frame();
    }

    fn key_down_event(
        &mut self,
        _ctx: &mut Context,
        keycode: KeyCode,
        _keymods: KeyMods,
        _repeat: bool,
    ) {
        self.keys.push(key_code_to_u16(keycode));
    }

    fn key_up_event(&mut self, _ctx: &mut Context, keycode: KeyCode, _keymods: KeyMods) {
        self.keys.retain(|key| *key != key_code_to_u16(keycode));
    }
}

fn key_code_to_u16(key_code: KeyCode) -> u16 {
    match key_code {
        KeyCode::Space => 0x20,
        KeyCode::Apostrophe => 0x21,
        KeyCode::Comma => 0x22,
        KeyCode::Minus => 0x23,
        KeyCode::Period => 0x24,
        KeyCode::Slash => 0x25,
        KeyCode::Key0 => 0x26,
        KeyCode::Key1 => 0x27,
        KeyCode::Key2 => 0x28,
        KeyCode::Key3 => 0x29,
        KeyCode::Key4 => 0x2A,
        KeyCode::Key5 => 0x2B,
        KeyCode::Key6 => 0x2C,
        KeyCode::Key7 => 0x2D,
        KeyCode::Key8 => 0x2E,
        KeyCode::Key9 => 0x2F,
        KeyCode::Semicolon => 0x30,
        KeyCode::Equal => 0x31,
        KeyCode::A => 0x41,
        KeyCode::B => 0x42,
        KeyCode::C => 0x43,
        KeyCode::D => 0x44,
        KeyCode::E => 0x45,
        KeyCode::F => 0x46,
        KeyCode::G => 0x47,
        KeyCode::H => 0x48,
        KeyCode::I => 0x49,
        KeyCode::J => 0x4A,
        KeyCode::K => 0x4B,
        KeyCode::L => 0x4C,
        KeyCode::M => 0x4E,
        KeyCode::N => 0x4F,
        KeyCode::O => 0x50,
        KeyCode::P => 0x51,
        KeyCode::Q => 0x52,
        KeyCode::R => 0x53,
        KeyCode::S => 0x54,
        KeyCode::T => 0x55,
        KeyCode::U => 0x56,
        KeyCode::V => 0x57,
        KeyCode::W => 0x58,
        KeyCode::X => 0x59,
        KeyCode::Y => 0x5A,
        KeyCode::Z => 0x5B,
        KeyCode::LeftBracket => 0x22,
        KeyCode::Backslash => 0x22,
        KeyCode::RightBracket => 0x22,
        KeyCode::GraveAccent => 0x22,
        KeyCode::World1 => 0x22,
        KeyCode::World2 => 0x22,
        KeyCode::Escape => 0x22,
        KeyCode::Enter => 0x22,
        KeyCode::Tab => 0x22,
        KeyCode::Backspace => 0x22,
        KeyCode::Insert => 0x22,
        KeyCode::Delete => 0x22,
        KeyCode::Right => 0x22,
        KeyCode::Left => 0x22,
        KeyCode::Down => 0x22,
        KeyCode::Up => 0x22,
        KeyCode::PageUp => 0x22,
        KeyCode::PageDown => 0x22,
        KeyCode::Home => 0x22,
        KeyCode::End => 0x22,
        KeyCode::CapsLock => 0x22,
        KeyCode::ScrollLock => 0x22,
        KeyCode::NumLock => 0x22,
        KeyCode::PrintScreen => 0x22,
        KeyCode::Pause => 0x22,
        KeyCode::F1 => 0x22,
        KeyCode::F2 => 0x22,
        KeyCode::F3 => 0x22,
        KeyCode::F4 => 0x22,
        KeyCode::F5 => 0x22,
        KeyCode::F6 => 0x22,
        KeyCode::F7 => 0x22,
        KeyCode::F8 => 0x22,
        KeyCode::F9 => 0x22,
        KeyCode::F10 => 0x22,
        KeyCode::F11 => 0x22,
        KeyCode::F12 => 0x22,
        KeyCode::F13 => 0x22,
        KeyCode::F14 => 0x22,
        KeyCode::F15 => 0x22,
        KeyCode::F16 => 0x22,
        KeyCode::F17 => 0x22,
        KeyCode::F18 => 0x22,
        KeyCode::F19 => 0x22,
        KeyCode::F20 => 0x22,
        KeyCode::F21 => 0x22,
        KeyCode::F22 => 0x22,
        KeyCode::F23 => 0x22,
        KeyCode::F24 => 0x22,
        KeyCode::F25 => 0x22,
        KeyCode::Kp0 => 0x22,
        KeyCode::Kp1 => 0x22,
        KeyCode::Kp2 => 0x22,
        KeyCode::Kp3 => 0x22,
        KeyCode::Kp4 => 0x22,
        KeyCode::Kp5 => 0x22,
        KeyCode::Kp6 => 0x22,
        KeyCode::Kp7 => 0x22,
        KeyCode::Kp8 => 0x22,
        KeyCode::Kp9 => 0x22,
        KeyCode::KpDecimal => 0x22,
        KeyCode::KpDivide => 0x22,
        KeyCode::KpMultiply => 0x22,
        KeyCode::KpSubtract => 0x22,
        KeyCode::KpAdd => 0x22,
        KeyCode::KpEnter => 0x22,
        KeyCode::KpEqual => 0x22,
        KeyCode::LeftShift => 0x22,
        KeyCode::LeftControl => 0x22,
        KeyCode::LeftAlt => 0x22,
        KeyCode::LeftSuper => 0x22,
        KeyCode::RightShift => 0x22,
        KeyCode::RightControl => 0x22,
        KeyCode::RightAlt => 0x22,
        KeyCode::RightSuper => 0x22,
        KeyCode::Menu => 0x22,
        KeyCode::Unknown => 0x98,
    }
}
