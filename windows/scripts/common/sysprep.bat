if exist A:\unattend.xml (
  C:\Windows\System32\Sysprep\sysprep.exe /generalize /oobe /shutdown /unattend:a:\unattend.xml
) else (
  del /F C:\Windows\System32\Sysprep\unattend.xml
  C:\Windows\System32\Sysprep\sysprep.exe /generalize /oobe /shutdown /quiet
)