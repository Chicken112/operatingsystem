/// MakeShift header file lol -------------------
//void print();
unsigned int getLength(char string[]);
void printString(char str[], int line);

void randomfunc(){
    return;
}

///Actual entry point ---------------------------
int entry(){
    char* videoMemory = (char*) 0xb8000;
    char str_loadedkernel[] = "Kernel loaded";
    printString(str_loadedkernel,3);

    while(1){ }
}

void printString(char str[], int line){
    char* videoMemory = (char*) 0xb8000;
    const int lineOffset = line * 160;
    for(int i = 0; i < getLength(str); i++) {
        videoMemory[lineOffset + i*2] = str[i];
        videoMemory[lineOffset + i*2 + 1] = 0x07;
    }
}

unsigned int getLength(char string[]){
    int length = 0;
    for(length = 0; string[length] != '\0'; ++length);
    return length;
}