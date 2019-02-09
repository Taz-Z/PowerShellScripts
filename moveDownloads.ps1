$downloadsFolder = "D:\ExamplePath"
$targetFolder = "D:\TvShows"
Get-ChildItem -Path $downloadsFolder -Filter *.mkv | ForEach-Object { # Can add multiple extensions as well

    #Movies/Shows I download are named as such: [NameOfDistributer] Game Of Thrones - S01E1 [1080p]
    $nameOfFolder = $_.Name.Substring(     #This makes the folder's name:Game Of Thrones
        $_.Name.IndexOf("]") + 2, 
        $_.Name.IndexOf("-") - $_.Name.IndexOf("]") - 2
     )
     
    # Full path, in this case: D:\TvShows\Game Of Thrones
    [System.IO.FileInfo]$destinationFolder = (Join-Path -Path $targetFolder -ChildPath $nameOfFolder)


     # Create the directory if it doesn't already exits
    if (!(Test-Path $destinationFolder)) { 
        New-item -Path $destinationFolder -ItemType Directory 
    }

    # Move the video to the new/existing folder for the specified show
    Move-Item -LiteralPath $_.FullName -Destination $destinationFolder.FullName  
}
