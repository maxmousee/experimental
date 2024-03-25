mod aap;
// use aap::aap;

mod noot;
use noot::Post;

fn main() {
    aap::aap();
    // aap();

    let mut post = Post::new();
    post.noot();
}