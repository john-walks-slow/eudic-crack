# Run as admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}


function blockProgram($programPath) {
    $programName = $programPath.Split("\")[-1]
    $existingRule = Get-NetFirewallRule -DisplayName $programName -erroraction 'silentlycontinue'
    if ($null -ne $existingRule) {
        Remove-NetFirewallRule -DisplayName $programName
    }
    New-NetFirewallRule -DisplayName $programName -Direction Outbound -Program $programPath -Protocol TCP -Action Block
    
}


$eudicPath = "C:\Program Files\eudic\eudic.exe"
# Check if C:\Program Files\eudic\eudic.exe exist
if (!(Test-Path $eudicPath)) {
    $eudicPath = $null
    Write-Host "> ��ѡ��ŷ·�ʵ�������"
    Add-Type -AssemblyName System.Windows.Forms
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        Title            = "ѡ��ŷ·�ʵ�������"
        InitialDirectory = [Environment]::GetFolderPath('ProgramFiles')
        Filter           = "eudic.exe|eudic.exe"
    }
    $dialogResult = $FileBrowser.ShowDialog()
    if ($dialogResult -eq "OK") {
        $eudicPath = $FileBrowser.FileName;
    }
}
if ($null -ne $eudicPath) {
    Write-Host "������" $eudicPath
    
    Write-Host "�����޸�ע��� ..."
    $regPath = $PSScriptRoot + "\register.reg"
    reg import $regPath
    
    # ����Ƿ��Ѵ���ͬ������
    Write-Host "���ڸ��·���ǽ���� ..."
    $eudicQtPath = $eudicPath.Replace("eudic.exe", "QtWebEngineProcess.exe")
    blockProgram($eudicPath)
    blockProgram($eudicQtPath)
    read-host "> �ƽ���ɣ����������Ч"
}
else {
    read-host "> û���ҵ� eudic.exe"
}
