# Run as admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

$eudicPath = "C:\Program Files\eudic\eudic.exe"
# Check if C:\Program Files\eudic\eudic.exe exist
if (!(Test-Path $eudicPath)) {
    $eudicPath = $null
    Write-Host "> 请选择欧路词典主程序"
    Add-Type -AssemblyName System.Windows.Forms
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        Title            = "选择欧路词典主程序"
        InitialDirectory = [Environment]::GetFolderPath('ProgramFiles')
        Filter           = "eudic.exe|eudic.exe"
    }
    $dialogResult = $FileBrowser.ShowDialog()
    if ($dialogResult -eq "OK") {
        $eudicPath = $FileBrowser.FileName;
    }
}
if ($null -ne $eudicPath) {
    Write-Host "主程序：" $eudicPath

    Write-Host "正在修改注册表 ..."
    $regPath = $PSScriptRoot + "\register.reg"
    reg import $regPath

    # 检查是否已存在同名规则
    Write-Host "正在更新防火墙规则 eudic_block ..."
    $existingRule = Get-NetFirewallRule -DisplayName "eudic_block" -erroraction 'silentlycontinue'

    if ($null -eq $existingRule) {
        # 如果规则不存在，则添加防火墙规则
        New-NetFirewallRule -DisplayName "eudic_block" -Direction Outbound -Program $eudicPath -Protocol TCP -RemotePort 443 -Action Block
    }
    else {
        # 如果规则已存在，则输出消息表示规则已存在
        Set-NetFirewallRule -DisplayName "eudic_block" -Direction Outbound -Program $eudicPath -Protocol TCP -RemotePort 443 -Action Block
    }
    read-host "> 破解完成，重启软件生效"
}
else {
    read-host "> 没有找到 eudic.exe"
}
