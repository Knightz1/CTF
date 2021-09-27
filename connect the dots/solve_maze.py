f=open('maze_dump.bin', 'rb').read()
maze=[]
for i in range(0,len(f),4):
	maze.append(f[i])

def walk(maze, x0,y0):
    visited = [0 for i in range(len(maze))]
    q= []
    q.append([x0])
    while (len(q) != 0):
        path = q.pop()
        x = path[-1]
        visited[x] = True
        if (x ==y0):
            return path
        status = maze[x]
        neighbor = []
        if  status&1==0:
            neighbor.append(x-1)
        if  status&2==0:
            neighbor.append(x+60)
        if  status&8==0:
            neighbor.append(x-60)
        if  status&4==0:
            neighbor.append(x+1)
        
        new_path = [path + [x] for x in neighbor if not visited[x]]
        q += new_path
    

def find_res(a1,a2):
    x0,y0=a1,a2
    sol = walk(maze,x0,y0)

    p=""
    for i in range(len(sol)-1):
        if sol[i+1]-sol[i]==1:
            p+='l'
        if sol[i+1]-sol[i]==-1:
            p+='h'
        if sol[i+1]-sol[i]==60:
            p+='j'
        if sol[i+1]-sol[i]==-60:
            p+='k'
    print(p)

find_res(0,2937)  #(2937,1734)....(675,1458)

#input: 
#lljhjjljljlljjjhhkhjjjlklljlkkllkhhklkhklkljlljhhjljlllkkhkkljlklljlkkhhhkhjhkkllljllklljhjjlklkklljhjljhjjljhjhjljlllkhhklkkllkhhkklkhklllljlllljljhhhkhhhhjlljlllljjhjlljhhjlljljhjljlklljlklkkkhjhjhhkklkkkhkhhkllljljjljlkljjljllkkkhkkkhklkkkljlllllkljljhjjljjjhhhhhkklljlkkhhkllkhhhhhjjljhjljjjjlljlllljljjhhjjhjjjhkhkkkkljlkkkhhhhjljhjhjljjhjllljllljjljjhkhhjjhkhjhkkkhklkhhjhjhkkkhjhhkhhjljjjhhjhjljjljlkkllljlkljjjjlkklllkkljjjljjjhhkhjhhjhhkhhjjlljllklljlklklljhjhjhhjhjjllklkllkljlkkhkllklkhhhkhklllkklllkkklkljllkkhkhhjhjhhjljhhjhkhkllkkllkhkllkkkljljjlklllkljjhjhjlljjjhjjjljjhhjljjhjhhkhjhhhjjjljllllllkkljjjjhjjhjhjjljhhjllxjljjjljhhhhhhklkkljjllkhkkhhhjhjhjjhjhhhkkhkkhjjhkkhklkkhjhhhklkkhjhkkhhkhkkhkhhhjhjhjhjljlkklllkljjjhjljlklkljjhjlljjlklljjljjljjljjljlljhhhkhhjhkhkkklkkkhkhhhkhjhjhjhkhhkhklkkljjljlklkkhjhkkhhhkhhkhkkklklkhhhhkklkljjlllklljllkkhhkklkhkklljjjljlllljhjhkhhjljjlklljljjhjljljjlkkllkhkhhkkljlkkllllkllkhkklklkkkljjjlkkkkkklxhjjjjjjhkkkhjjjhjhjjljhhjhhhhjjhkhjjlljljhhjjhkkhkhklkkhkhhjhkkhklljlklkhhhhkhkkkhhjjljhjjlljjhhkhhjhhhkkhjhjjlllljhjhjjjljlljllljjlkljjhjhkhkkhjjhjljlljlklklkljllljljjjhjjjljlklljxkhhjhkhkkklkkkhkhhhkhjhjhjhkhhkhklkkljjljlklkkhjhkkhhhkhhkhkkklklkhhhhkklkljjlllklljlxhkhhjhhhkkhjhjjlllljhjhjjjljlljllljjlkljjhjhkhkkhjjhjljlljlklklkljllljljjjhjjjljlklljlllkhhkhkkhkkhkkhkkhhjhkkhhklkkhjhjhkhklkkkhjhhhjjhkhklklklkllljljjljlljjlkljjhjlllkljjhjljjlkkljjljjlllklkklklkllljjljhhkkhjjhjllllllkhkkkhkhhkllkhkklklkklkkkkhjjhhhhhhkhkkklllkljllklkkhkllkkhkkklkkkhhklklkkhjhhhjhkkhkhjjjhhjljhhjjhhjljlkllkhkllklklljljjhhkhjhjjjhhhjjhhhjljllljhjhhjljjhkhjhhjhjhhkklkllklklkhhjhjhkhhjhhkhhkklljllkllkljllkkkhkkkhjjhhhjjhkkkkhjhkhhhjjhkhkkhklkllkkkhklljxkhhjljjjhhjhjljjljlkkllljlkljjjjlkklllkkljjjljjjhhkhjhhjhhkhhjjlljllklljlklklljhjhjhhjhjjllklkllkljlkkhkllklkhhhkhklllkklllkkklkljllkkhkhhjhjhhjljhhjhkhkllkkllkhkllkkkljljjlklllkljjhjhjlljjjhjjjljjhhjljjhjhhkhjhhhjjjljllllllkkljjjjhjjhjhjjljhhjlljljjjljhhhhhhklkkljjllkhkkhhhjhjhjjhjhhhkkhkkhjjhkkhklkkhjhhhklkkhjhkkhhkhkkhkhhhjhjhjhjljlkklllkljjjhjljlklkljjhjlljjlklljjljjljjljjljlljhhhkhhjhkhkkklkkkhkhhhkhjhjhjhkhhkhklkkljjljlklkkhjhkkhhhkhhkhkkklklkhhhhkklkljjlllklljllkkhhkklkhkkllkhhhjhkkkkkkhkhkkllkkhjhkhklkklkhhkklkhkkllkhhkkkhhklkkhjhjhjljjjjhhjjhhhjhjhjhhkkllklkhkhhhkhhhkkhhjhkhhjjljjlklkljjlljjhkhhjjjlllljhhjlllklljjhjhjljhhjljlljljhjlljhjljlkllljjljjjhkhkhjjjljljlkljjhjjljhjllljjhjjjjhkhjhkhjjhhklkhhjhkhhhklklkkkhhjjhjjjhhjljjhhhjhhjjhhhjhjjjljhhhkklkhklkhhklkkhkhklkkhkkllllljhhhjlljjjhjljjllkhkkkklljlkllkllklkkkhjhjjhhhhkhklklkkhjhkkllkljlljjlkllljllkljlkljljjhhjljljllkllkkhhhklkhkhkhhhhhkkkhjjhjhkhkkhjhkhhkkhhkhjhhhkkhjjjlljlkllljjjhhkhjhjljjljhjhkhjhhkkllkkkhjhkklkhkkkkkklkljljjjlklllllkkkljjlkkkhkhhkllllkkhjhkhjhhhkkkkhjhhkhkkkljjlllljlkkkhjhkkkkklkljljjhhjlljjlljjlljhjljjljlljhhhhjllljhhjjljhhjljhhxllkhkllkhkkllkhhhkllllkhhkhkkhklkhhkkhhkkhhkllkkhkhjhjjjjjlkljjjhkhhhhkkhjjjljllkljjjjlllkljlkljjhhhhjlljljjjhkkhjjjhhhhhjhkkkhkhjhjjjjjjljhjjlkljjjhhjjllkljlklkhkkhklkljllkkkhhhjhkhhkkkljjlllkljlljjlljlkljjljlklkkljjjllllljljljhjllljjhhjhhkhkhkllkkhkhjhkhjhhkhhhjhkkhhkhjhhjjlkljjhjhjljllllkklkljjjhjhhjhhjhkhhjjjjljhhkkhklkkkhhklllkhhhhhjjljjhjljljjhjlljhjljhjjlllkhkkklklllkkllklllkkhkllkkklkklljjjhjhjllljlklljhjllkkljlkljlkkkklkkhhhklkhkklkkhjhkhkhkkkljljlkkkhkkhhhjhkhklkhhklkhkhhkhkllkhklklkkhhjhhhkllkhhhhkkklljlkkhhkkhjhjhkkhkklljlklljjlllxhhhkkhhjhkhhjjljjlklkljjlljjhkhhjjjlllljhhjlllklljjhjhjljhhjljlljljhjlljhjljlkllljjljjjhkhkhjjjljljlklkklljlkkhhhklklkkhklkkllkhkhkhhjljjhhkhkhklkklkkhjhkhhklkkkhjjhhjljjljjljjjhjhkkkkkhkhjjljx
    
