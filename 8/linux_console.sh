# Фрагмент 1
 
sudo cat /etc/sudoers
Defaults        secure_path="/tmp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
CHECKSITE   ALL = NOPASSWD: /opt/run.sh
 
ls -alh /opt/
total 20K
drwxrwxr-x  2 somebody somebody 4,0K Mar  2 13:37 .
drwxr-xr-x 96 somebody somebody  12K Mar  2 14:06 ..
-rwxr-xr--  1 root     root       80 Mar  2 13:39 run.sh
 
cat /opt/run.sh
#!/bin/bash
 
read -p "Enter website to check connection: " website
curl $website
 
 
# ---------------------------------------------------------------------------
 
# Фрагмент 2

 
ls -alh /opt
total 44K
drwxrwxr-x  2 somebody somebody 4,0K Mar  2 15:49 .
drwxr-xr-x 97 somebody somebody  12K Mar 13 14:41 ..
-rwsr-sr-x  1 root     root      19K Mar  2 15:49 run
-rwxr--r--  1 root     root      389 Mar  2 15:47 run.c
-rwx------  1 root     root       10 Mar  2 15:26 test
 
cat run.c 
 
#include <iostream>
#include <string>
#include <unistd.h>
 
int main()
{
    std::string website;
    std::cout << "Enter website to check connection:" << std::endl;
    std::getline(std::cin, website);
    std::cout << website << std::endl;
    std::string command;
    command = "curl " + website;
    const char * exec = command.c_str();
    setuid(0);
    system(exec);
    return 0;
}
