#include <stdio.h>

extern char * perl_eval(char * str);

int main(int argc, char * argv[])
{
    perl_eval("print qq#Hello World\\n#;");
    return 0;
}
