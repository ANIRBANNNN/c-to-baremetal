#include<stdio.h>

struct Pixel{
    unsigned char r;
    unsigned char g;
    unsigned char b;
    int k;
}__attribute__((packed));

void main(){
    struct Pixel p1 = {255,0,0};
    printf("Size of Pixel struct: %lu\n",sizeof(p1));
    printf("Red: %u\n",p1.r);
    printf("Green: %u\n",p1.g);
    printf("Blue: %u\n",p1.b);
}