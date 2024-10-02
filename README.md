# Tinypng bulk optimization
A powershell script that optimize PNG images through tinypng.com. 
In order to use it you [need to get API key]([url](https://tinypng.com/developers)).
![image](https://github.com/user-attachments/assets/62cd228f-8850-4a44-bcf1-8c83c7f4f4ae)

This PowerShell script optimizes PNG images using the Tinify API. It processes all `.png` files in a specified root directory and retains the original folder structure in a designated output directory.

## Features
- Recursively searches for `.png` files in the specified root directory.
- Optimizes images using the Tinify API.
- Maintains the original folder structure in the output directory.
- Displays a progress bar during the optimization process.

## Prerequisites
- PowerShell installed on your system.
- Tinify [API key]([url](https://tinypng.com/developers)).

## Configuration

1. Update the following variables with your Tinify API credentials: `$pass = "your_api_key"`
2. Specify the root folder containing images `$rootFolder = "images"`
3. Specify the output folder for optimized images `$outputRootFolder = "tiny"` 

## Usage

1. Open PowerShell.
2. Navigate to the directory where the script is saved.
3. Run the script:
`.\your_script_name.ps1`

## Output

- The optimized images will be saved in the `tiny` directory, maintaining the same folder structure as in the `images` directory.

## Notes

- Ensure that the `images` directory exists and contains `.png` files before running the script.
- The script will display a progress bar indicating the optimization status.
