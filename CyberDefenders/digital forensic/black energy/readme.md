## Which process shows the highest likelihood of code injection?

Đáng nghi là `svchost.exe`: `purpose of svchost.exe is to act as a container or “host” for various Windows services so that these services can be run more efficiently by sharing system resources.`

![1](https://user-images.githubusercontent.com/91442807/229555226-74a1da0c-1f2a-4b9b-b19b-56d5cfc131f8.png)

Dùng `malfind` plugin để phân tích tiến trình này thử:

![1](https://user-images.githubusercontent.com/91442807/229555711-0cd9f2ad-52b8-4488-82f7-d263ba51c9e7.png)

- Có vẻ như tiến trình đó bị inject đó một tập tin PE.

## There is an odd file referenced in the recent process. Provide the full path of that file.

`python vol.py -f ../CYBERDEF-567078-20230213-171333.raw --profile=WinXPSP2x86 handles -p 880 -t file` 

Sử dụng plugin `handles` và search loại tệp là file trong proccess `880`.

![1](https://user-images.githubusercontent.com/91442807/229556651-9108ea71-8cf4-472f-9b42-f15dd67924f2.png)

File tên `str.sys` khá là lạ.

## What is the name of the injected dll file loaded from the recent process?

Dùng plugin `ldrmodules` để phát hiện các `unlinked DLLs`:

`python vol.py -f ../CYBERDEF-567078-20230213-171333.raw --profile=WinXPSP2x86  -p 880 ldrmodules`

![1](https://user-images.githubusercontent.com/91442807/229557565-89cf8c97-9660-41b3-afc1-0f666609ecb0.png)

Thì ta thấy file tên `msxml3r.dll` có `base address` = 0x9a0000 bằng với base address của tệp PE được chèn vào proccess ở trên.



