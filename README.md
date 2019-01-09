# WindowsWallpaperExtractor

WindowsWallpaperExtractor is a script that extracts the lock/loginscreen wallpaper from the operating system so they can also be used for the desktop.
1. It retreives the files from the Assets folder deep down in ProgramFiles and puts them in a conversion folder to convert them.
2. It then adds an .jpg extension to them because they don't have an extension before.
3. It then copy's the jpg pictures from the conversion folder with robocopy over to the destination folder to verify if the picture already exists.
4. It then goes through the pictures and deletes everything that isn't a valid wallpaper size (1920x1080).
5. Then it finally deletes everything from the conversion folder, otherwise there will be lot's of unwanted files in the destination folder.
