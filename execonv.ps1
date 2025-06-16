Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

function Request-Elevation {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
}

function Check-AndInstall-PS2EXE {
    if (-not (Get-Module -ListAvailable -Name ps2exe)) {
        $msg = "The 'ps2exe' module is not installed. Do you want to install it now?"
        $result = [System.Windows.MessageBox]::Show($msg, "Install ps2exe?", "YesNo", "Question")
        if ($result -eq "Yes") {
            Request-Elevation
            Install-Module -Name ps2exe -Scope CurrentUser -Force
        } else {
            [System.Windows.MessageBox]::Show("ps2exe is required to continue.", "Exiting", "OK", "Error")
            exit
        }
    }
}

function Select-File($title, $filter) {
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Title = $title
    $dialog.Filter = $filter
    if ($dialog.ShowDialog() -eq "OK") {
        return $dialog.FileName
    } else {
        return $null
    }
}

function Convert-ToEXE {
    Check-AndInstall-PS2EXE

    $inputFile = Select-File "Select PowerShell Script (.ps1)" "PowerShell Scripts|*.ps1"
    if (-not $inputFile) { return }

    $iconFile = Select-File "Select Icon File (.ico)" "Icon Files|*.ico"
    if (-not $iconFile) { return }

    $outputFile = [System.IO.Path]::ChangeExtension($inputFile, ".exe")

    try {
        Invoke-ps2exe -inputFile $inputFile -outputFile $outputFile -iconFile $iconFile -noConsole
        [System.Windows.MessageBox]::Show("Successfully created EXE:`n$outputFile", "Success", "OK", "Information")
    } catch {
        [System.Windows.MessageBox]::Show("Failed to compile:`n$($_.Exception.Message)", "Error", "OK", "Error")
    }
}

function Show-MainWindow {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "EXE Converter"
    $form.Size = New-Object System.Drawing.Size(300,150)
    $form.StartPosition = "CenterScreen"

    $button = New-Object System.Windows.Forms.Button
    $button.Text = "Convert"
    $button.Size = New-Object System.Drawing.Size(100,40)
    $button.Location = New-Object System.Drawing.Point(100,40)
    $button.Add_Click({
        Convert-ToEXE
    })

    $form.Controls.Add($button)
    [void]$form.ShowDialog()
}

Show-MainWindow
