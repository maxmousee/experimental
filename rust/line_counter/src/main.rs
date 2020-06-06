use std::{io, env};
use std::iter::Iterator;
use std::io::{BufRead, BufReader};
use std::fs::{self};

const LF: u8 = '\n' as u8;

pub fn count_lines<R: io::Read>(handle: R) -> Result<usize, io::Error> {
    let mut reader = BufReader::new(handle);
    let mut count = 0;
    let mut line: Vec<u8> = Vec::new();
    while match reader.read_until(LF, &mut line) {
        Ok(n) if n > 0 => true,
        Err(e) => return Err(e),
        _ => false,
    } {
        if *line.last().unwrap() == LF {
            count += 1;
        };
    }
    count+=1;
    Ok(count)
}

fn count_lines_dir(dir_path: &String) {
    let files_in_directory = fs::read_dir(dir_path).unwrap();
    let mut total = 0;
    for path in files_in_directory {
            let file_path = path.unwrap();
            if file_path.path().is_file() && !file_path.file_name().to_str().unwrap().starts_with(".") {
                println!("File: {}", file_path.path().display());
                let lines: usize = count_lines(std::fs::File::open(file_path.path()).unwrap()).unwrap();
                println!("Number of lines: {}", lines);
                total += lines
            }
    }
    println!("Total lines in folder: {}", total)
}

fn main() -> io::Result<()> {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        println!("Missing directory as argument, aborting...");
    } else {
        let directory = &args[1];
        println!("Checking files in: {}", directory);
        count_lines_dir(directory);
    }
    Ok(())
}
