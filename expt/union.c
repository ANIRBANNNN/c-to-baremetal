#include<stdio.h>

union Pixel{
   char a;
   short b;
};

void main(){
    union Pixel p1;
    printf("Size of Pixel union: %lu\n",sizeof(p1));
}