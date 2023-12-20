#include <stdio.h>
#include <string.h>
#include <stdlib.h>
//char pass[] = "Shadow{Eminence_in_shadow}";
void do_input(){
    int key = 0x12345678;
    char buffer[32];
    char pass[] = "Shadow{Eminence_in_shadow}";
    printf("Is Alpha better than Beta?? ");
    fflush(stdout);
    gets(buffer);
    if(key == 0xdeadbeef){
        printf("Are you dumb???!!\n");
        printf("%04x\n", key);
        printf("oops?? %s", pass);
        fflush(stdout);
    }
    else{
        printf("%04x\n", key);
        printf("...\n");
        fflush(stdout);
    }
}

int main(int argc, char* argv[]){
    do_input();
    return 0;
}