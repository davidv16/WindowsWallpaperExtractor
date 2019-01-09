[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

$imageOrigin = "C:\Users\david\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\*"
$quickStopFolder = "C:\Users\david\Pictures\millifaersla\"
$destinationFolder = "C:\Users\david\Pictures\desktop myndir"

#get pictures from assets
Copy-Item $imageOrigin  -Destination $quickStopFolder -Recurse

# change extension to jpg
Dir $quickStopFolder * | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "jpg") }

robocopy /xc /xn /xo $quickStopFolder $destinationFolder

Get-ChildItem $destinationFolder *.jpg | ForEach-Object {
	$img = [Drawing.Image]::FromFile($_.FullName)
	if($img.Width -lt 1920 -or $img.Height -lt 1080) {
		$_
		$img.Dispose()
		Remove-Item $_.FullName
    }
}

Get-ChildItem -Path $quickStopFolder -Include *.* -File -Recurse | foreach { $_.Delete()}


