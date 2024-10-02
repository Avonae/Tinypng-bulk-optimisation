$pass = "your_api_key_here"
$user = "api"
$pair = "${user}:${pass}"

$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)

$basicAuthValue = "Basic $base64"
$headers = @{ Authorization = $basicAuthValue }
$regex = '"url":".*?"'

# Set the root folder for optimization
$rootFolder = "images"
# Folder to save optimized images
$outputRootFolder = "tiny"

# Count all .png files
$files = Get-ChildItem -Path $rootFolder -Recurse -Include *.png
$totalFiles = $files.Count
$currentFile = 0

# Create output directory if it doesn't exist
md -force $outputRootFolder

foreach ($file in $files) {
    $currentFile++
    # Send request to Tinify API to optimize the image
    $return = Invoke-WebRequest -uri "https://api.tinify.com/shrink" -Headers $headers -InFile $file.FullName -Method Post
    $urlMatch = Select-String -InputObject $return.Content -Pattern $regex -AllMatches
    if ($urlMatch) {
        # Extract the optimized image URL from the response
        $url = $urlMatch.Matches[0].Value.Replace('"url":"','').Replace('"','')

        # Determine the relative path for saving the optimized image
        $relativePath = $file.FullName.Substring($rootFolder.Length).TrimStart('\')
        $outputPath = Join-Path -Path $outputRootFolder -ChildPath $relativePath

        # Create the directory if it doesn't exist
        $outputDir = Split-Path -Path $outputPath -Parent
        md -force $outputDir

        # Download the optimized image to the output path
        Invoke-WebRequest -Uri $url -OutFile $outputPath
    } else {
        Write-Host "Error: URL not found for file $($file.FullName)"
    }

    # Update the progress bar
    $progress = ($currentFile / $totalFiles) * 100
    Write-Progress -Activity "Optimizing images" -Status "$currentFile of $totalFiles" -PercentComplete $progress
}

Write-Host "Optimization completed!"
