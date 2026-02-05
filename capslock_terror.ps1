Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public class Keyboard {
    [DllImport("user32.dll")]
    public static extern short GetKeyState(int nVirtKey);
    [DllImport("user32.dll")]
    public static extern void keybd_event(byte bVk, byte bScan, int dwFlags, int dwExtraInfo);
}
'@

while ($true) {
    $caps = [Keyboard]::GetKeyState(0x14)
    if (($caps -band 0x0001) -eq 0) {
        [Keyboard]::keybd_event(0x14,0x45,0x0001,0)
    }
    Start-Sleep -Milliseconds 500
}
