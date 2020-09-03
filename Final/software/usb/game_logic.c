#include "game_logic.h"
#include "parameter.h"
#include "kirby.h"
#include "test.h"

Game GameStart() {
    Game game_state;
    Kirby kirby;
    initial_Kirby(kirby);
    initial_Game_State(game_state);

    int keycode = 0;
    int pre_keycode = 0;

    usb_initialize();

    while (1)
    {
        pre_keycode = keycode;
        keycode = get_keycode_value();

        // test_keyboard(keycode);
        updateKirby(kirby, keycode, pre_keycode);
        upload_Kirby_Info(kirby, game_state);
    }
    
}

void initial_Game_State (Game game_state) {
    game_state.interrupt = 0;
    game_state.map = 0;
}
