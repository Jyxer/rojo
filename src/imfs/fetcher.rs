use std::{
    io,
    path::{Path, PathBuf},
};

use crossbeam_channel::Receiver;

use super::event::ImfsEvent;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum FileType {
    File,
    Directory,
}

/// The generic interface that `Imfs` uses to lazily read files from the disk.
/// In tests, it's stubbed out to do different versions of absolutely nothing
/// depending on the test.
pub trait ImfsFetcher {
    fn file_type(&mut self, path: &Path) -> io::Result<FileType>;
    fn read_children(&mut self, path: &Path) -> io::Result<Vec<PathBuf>>;
    fn read_contents(&mut self, path: &Path) -> io::Result<Vec<u8>>;

    fn create_directory(&mut self, path: &Path) -> io::Result<()>;
    fn write_file(&mut self, path: &Path, contents: &[u8]) -> io::Result<()>;
    fn remove(&mut self, path: &Path) -> io::Result<()>;

    fn watch(&mut self, path: &Path);
    fn unwatch(&mut self, path: &Path);
    fn receiver(&self) -> Receiver<ImfsEvent>;

    /// A method intended for debugging what paths the fetcher is watching.
    fn watched_paths(&self) -> Vec<&Path> {
        Vec::new()
    }
}
