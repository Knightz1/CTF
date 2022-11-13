```python
from capstone import *
from capstone.x86 import *


md=Cs(CS_ARCH_X86, CS_MODE_64)
f=open('inss.txt','r').read()
code=open('elf','rb').read()[0x1155:0x18890]

call_graph={}
pattern=b'\x55\x48\x89\xe5'             #push rbp, mov rbp, rsp
idx=0
for inss in md.disasm(code,0x1155):
    #print(inss)
   
    if inss.mnemonic=='call' and inss.op_str[:2]=='0x':
        if inss.address>0x1155:
            if inss.op_str not in call_graph:
                if inss.op_str=='0x1050' or inss.op_str=='0x1040' or inss.op_str=='0x1030':
                    if inss.op_str=='0x1050':
                        if idx==0:
                            nn=hex(inss.address-9)
                            idx+=1
                    continue
                call_graph[inss.op_str]=[]


# print(call_graph)

for i in call_graph:
    # print(i)
    addr_func=i
    if addr_func==nn:continue
    mapp=[]
    ma=[]
    for ins in md.disasm(open('elf','rb').read()[int(addr_func,16):0x18890],int(addr_func,16)):
        if ins.address==int(addr_func,16) and ins.mnemonic=='push' and ins.op_str=='rbp':
            #print(f"Found:{ins.address} {ins.mnemonic} {ins.op_str}")
            sstc=1
        
        if ins.op_str.split(', ')[0]=='eax' and ins.mnemonic=='sub' or ins.mnemonic=="add" or ins.mnemonic=='xor':
            #print(f'{ins.mnemonic} {ins.op_str}')
            val=int(ins.op_str.split(', ')[1],16)
            if ins.mnemonic=='sub':
                status=1
            if ins.mnemonic=='add':
                status=2
            if ins.mnemonic=='xor':
                status=3
            
        if ins.mnemonic=='cmp':
            
            cmpval=int(ins.op_str.split(', ')[1],16)
            if cmpval not in ma:
                if status==1:
                    ma.append(cmpval)
                    mapp.append(str((cmpval+val)))
                if status==2:
                    ma.append(cmpval)
                    mapp.append(str((cmpval-val)&0xffffffff))
                if status==3:
                    ma.append(cmpval)
                    mapp.append(str(val^cmpval))
        
        if ins.mnemonic=="je":
            for k in md.disasm(open('elf','rb').read()[int(ins.op_str,16):0x18890],int(ins.op_str,16)):
                
                if k.mnemonic=='call' and k.op_str!='0x1040' and k.op_str!='0x1050' and k.op_str!='0x1030':
                    mapp.append(k.op_str)
                    break
        
        if ins.mnemonic=="jne":
            for k in md.disasm(open('elf','rb').read()[ins.address:0x18890],ins.address):
                
                if k.mnemonic=='call' and k.op_str!='0x1040' and k.op_str!='0x1050' and k.op_str!='0x1030':
                    mapp.append(k.op_str)
                    break

                      
        if ins.mnemonic=='ret':
            break
       
       
    call_graph[i]=mapp
print(call_graph)
print("Done")    

src=''
for mm in call_graph:
    if src=='':
        src=mm
        break
dest=nn
print(f'Start: {src}')
print(f'End: {dest}')    
queue = []                                          # 1.
visited = set()                                     # 2.
queue.append((src, ''))                             # 3.
while len(queue) > 0:                               # 4.0
    first, path = queue[0]
    if first == dest:                               # Handle reaching dest
        print(path,end='')
        break
    visited.add(first)                              # 4.1
    for index in range(len(call_graph[first])//2):     # Require index
        reachable = call_graph[first][2*index+1]
        if reachable not in visited:
            char = call_graph[first][2*index]                    # To get NEWS[index] for path//neu chon index thi lay char[index]
            queue.append((reachable, path + char+'\n'))  # 4.2
    del queue[0]
```
