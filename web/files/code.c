#include <stdio.h>
#include <unistd.h>
int main(int argc, char *argv[])
{
   int a = atoi(argv[1]);
   sleep(3);
   return a*a;
}
