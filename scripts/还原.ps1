# Run as admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
  exit;
}
Write-Host "正在还原防火墙规则 ..."
Remove-NetFirewallRule -DisplayName "eudic.exe" -erroraction 'silentlycontinue'
Remove-NetFirewallRule -DisplayName "QtWebEngineProcess.exe" -erroraction 'silentlycontinue'
Read-Host "> 已完成"