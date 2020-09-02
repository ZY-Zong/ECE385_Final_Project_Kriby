#include "game_logic.h"
#include "parameter.h"
#include "kirby.h"
#include "test.h"

void GameStart() {
    Kirby kirby;
    initial_Kirby(kirby);

    int keycode = 0;
    int pre_keycode = 0;

    usb_initialize();

    while (1)
    {
        pre_keycode = keycode;
        keycode = get_keycode_value();

        // test_keyboard(keycode);
        updateKirby(kirby, keycode, pre_keycode);
        upload_Kirby_Info(kirby);
    }
    
}