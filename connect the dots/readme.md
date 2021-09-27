Main function:

    __int64 __fastcall main(int a1, char **a2, char **a3)
    {
    __int64 result; // rax
    _DWORD varE10; // [rsp+0h] [rbp-E10h]
    _DWORD varE0C; // [rsp+4h] [rbp-E0Ch]
    _DWORD varE08; // [rsp+8h] [rbp-E08h]
    char buf[3576]; // [rsp+10h] [rbp-E00h]
    __int64 var8; // [rsp+E08h] [rbp-8h]

    var8 = __readfsqword(0x28u);
    buf[(int)(read(0, buf, 0xDEFuLL) - 1)] = 0;
    sub_563EA2B701E0(buf);
    puts("yes :>");
    for ( varE10 = 0; varE10 <= 43; ++varE10 )
    {
      varE0C = 1;
      for ( varE08 = 0; varE08 <= 80; ++varE08 )
        varE0C = varE0C * buf[81 * varE10 + varE08] % 255;
      putchar(varE0C ^ byte_563EA2B768C0[varE10]);
    }
    puts(&byte_563EA2B71057);
    return 0LL;
  }
