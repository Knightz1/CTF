## Finding profile 

`volatility -f Evidence.vmem imageinfo`

## Scanning active processes

`volatility -f Evidence.vmem --profile=profile_nào_đó pslist`

## Check cmd command history

`volatility -f Evidence.vmem --profile=profile_nào_đó cmdscan`

## check command executed in a process

`volatility -f Evidence.vmem --profile=profile_nào_đó cmdline -p PID`

## Get offset of a file 

`volatility -f Evidence.vmem --profile=profile_nào_đó filescan | grep "keylogger.py"`

## Dump file with that offset

`./volatility_2.6_lin64_standalone -f ../Evidence.vmem --profile=profile_nào_đó dumpfiles -o offset -D .`

## List hive list

`./volatility_2.6_lin64_standalone -f windows.vmem --profile=Win7SP1x64 hivelist`

## Dump registry file dựa trên offset

`./volatility_2.6_lin64_standalone -f windows.vmem --profile=Win7SP1x64 dumpregistry -o 0xfffff8a0018f0410 -D . `
