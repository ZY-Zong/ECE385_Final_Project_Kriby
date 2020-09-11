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
    // Game * game_state;
    // initial_Game_State(game_state);
    GameStart();

    printf("ERROR: Game interrupted!");
    return 0;
}
