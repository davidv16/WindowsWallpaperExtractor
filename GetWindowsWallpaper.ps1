[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

#folder paths
$imageOrigin = "C:\Users\david\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\*"
$conversionFolder = "C:\Users\david\Pictures\conversion\"
$destinationFolder = "C:\Users\david\Pictures\desktop pictures"

	#get pictures from assets and store them in a temporary folder
	Copy-Item $imageOrigin  -Destination $conversionFolder -Recurse

	#give them a .jpg extension
	Dir $conversionFolder * | Rename-Item -NewName { [io.path]::ChangeExtension($_.name, "jpg") }

	#copy files from the conversion folder to the destination folder while checking if they already exist in the destination
	robocopy /xc /xn /xo $conversionFolder $destinationFolder

	#erase all pictures that are not pictures and are smaller than desktop size
	Get-ChildItem $destinationFolder *.jpg | ForEach-Object {
		$img = [Drawing.Image]::FromFile($_.FullName)
		if($img.Width -lt 1920 -or $img.Height -lt 1080) {
			$_
			$img.Dispose()
			Remove-Item $_.FullName
		}
	}

#clean up conversion folder
Get-ChildItem -Path $conversionFolder -Include *.* -File -Recurse | foreach { $_.Delete()}


