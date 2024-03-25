pub struct Post {
    state: Option<Box<dyn State>>,
    content: String,
}

impl Post {
    pub fn new() -> Post {
        Post {
            state: Some(Box::new(Draft {})),
            content: String::new(),
        }
    }

    pub fn noot(&mut self) {
        println!("noot");
    }
}

trait State {}

struct Draft {}

impl State for Draft {}