# Run as admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
  exit;
}
Write-Host "���ڻ�ԭ����ǽ���� ..."
Remove-NetFirewallRule -DisplayName "eudic.exe" -erroraction 'silentlycontinue'
Remove-NetFirewallRule -DisplayName "QtWebEngineProcess.exe" -erroraction 'silentlycontinue'
Read-Host "> �����"