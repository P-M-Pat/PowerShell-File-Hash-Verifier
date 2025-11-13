Add-Type -AssemblyName System.Windows.Forms, System.Drawing

$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    InitialDirectory = [Environment]::GetFolderPath('Desktop')

    Title = "Select your file."

    Filter = "All Files (*.*)|*.*"
}

[void]$FileBrowser.ShowDialog()


if($FileBrowser.FileName -ne "") {
    $SelectedFile = $FileBrowser.FileName
    Write-Host "You selected: $SelectedFile" -ForegroundColor Cyan

    $HashValue = $SelectedFile | Get-FileHash -Algorithm SHA256
    Write-Host "The hash value of your file is:    $($HashValue.Hash)" -ForegroundColor Magenta

    Write-Host "Enter your SHA256 checksum to verify the integrity of your file" -ForegroundColor Yellow
    $UserHashVal = Read-Host
    
    if ($UserHashVal -eq $HashValue.Hash) {
        Write-Host "Your file is successfully verified!" -ForegroundColor Green
    } else {
        Write-Host "The hash values doesn't match" -BackgroundColor Red -ForegroundColor Black
    }
} else {
    Write-Host "File selection cancelled." -BackgroundColor Red -ForegroundColor Black 
}

