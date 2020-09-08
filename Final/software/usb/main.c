#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <io.h>
#include <fcntl.h>

#include "test.h"
#include "usb_main.h"
#include "parameter.h"
#include "game_logic.h"

int main(void) {
    GameStart();

    printf("Interupt takes place!");
    return 0;
}
