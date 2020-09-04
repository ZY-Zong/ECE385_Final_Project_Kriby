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
    Game * game_state;
    GameStart(game_state);

    printf("Interupt takes place!");
    return 0;
}
