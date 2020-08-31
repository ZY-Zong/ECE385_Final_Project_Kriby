
module  Kirby_State (
              input         Clk,                // 50 MHz clock
                            Reset,              // Active-high reset signal
            //                frame_clk,          // The clock indicating a new frame (~60Hz)
            //   input logic   is_damaged,
			  input [7:0]   keycode,
            //   input [9:0]   DrawX, DrawY,       // Current pixel coordinates
			//   input         initial_frame, final_frame, game_over,
            //   output logic  is_inhaled,
            //   output logic  game_over,
              output [2:0]  character_action_idx, // which action
			  output [3:0]  character_action_frame_idx   // which frame of this action
              );

    enum logic [4:0] {
        INI,
        STAND0,
        STAND1,
        RIGHT_MOVE0,
        RIGHT_MOVE1,
        RIGHT_MOVE2,
        RIGHT_MOVE3,
        RIGHT_MOVE4,
        RIGHT_MOVE5,
        RIGHT_MOVE6,
        RIGHT_MOVE7,
        RIGHT_MOVE8,
        RIGHT_MOVE9,
        LEFT_MOVE0,
        LEFT_MOVE1,
        LEFT_MOVE2,
        LEFT_MOVE3,
        LEFT_MOVE4,
        LEFT_MOVE5,
        LEFT_MOVE6,
        LEFT_MOVE7,
        LEFT_MOVE8,
        LEFT_MOVE9
        // JUMP,
        // SQUAT, //蹲
        // INHALE,
        // SPIT, //吐
        // DAMAGE,
        // DIE
    } curr_state, next_state;

    // logic [2:0] health;
    // logic is_dead;

    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
            curr_state <= INI;
        else
            curr_state <= next_state;
    end


    always_comb
    begin
        // default values for current state
        // is_dead = 1'b0;
        // health = 3'd5;

        // is_inhaled = 1'b0;
        // game_over = 1'b0;
        character_action_idx = 3'd0;
        character_action_frame_idx = 4'd0;
        next_state = curr_state;

        unique case (curr_state)
            //
                // STAND:
                //     begin
                //         if (is_dead) begin
                //             next_state = DIE;
                //         end
                //         else if (is_damaged) begin
                //             next_state = DAMAGE;
                //         end
                //         else if (((keycode == 8'h1A && is_inhaled == 0) || (keycode == 8'h09 && is_inhaled == 1)) begin
                //             next_state = JUMP;
                //         end
                //         else if (keycode == 8'h16 && is_inhaled == 0) begin
                //             next_state = SQUAT;
                //         end
                //         else if (keycode == 8'h16 && is_inhaled == 1) begin
                //             next_state = EAT;
                //         end
                //         else if (keycode == 8'h04) begin
                //             next_state = LEFT_MOVE;
                //         end
                //         else if (keycode == 8'h07) begin
                //             next_state = RIGHT_MOVE;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 1) begin
                //             next_state = SPIT;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 0) begin
                //             next_state = INHALE;
                //         end
                //         else begin
                //             next_state = STAND;
                //         end // Just stand and blinking
                //     end
                // RIGHT_MOVE:
                //     begin
                //         if (is_dead) begin
                //             next_state = DIE;
                //         end
                //         else if (is_damaged) begin
                //             next_state = DAMAGE;
                //         end 
                //         else if (((keycode == 8'h1A && is_inhaled == 0) || (keycode == 8'h09 && is_inhaled == 1)) begin
                //             next_state = JUMP;
                //         end
                //         else if (keycode == 8'h16) begin
                //             next_state = SQUAT;
                //         end
                //         else if (keycode == 8'h04) begin
                //             next_state = LEFT_MOVE;
                //         end
                //         else if (keycode == 8'h07) begin
                //             next_state = RIGHT_MOVE;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 1) begin
                //             next_state = SPIT;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 0) begin
                //             next_state = INHALE;
                //         end
                //         else begin
                //             next_state = STAND;
                //         end
                //     end
                // LEFT_MOVE:
                //     begin
                //         if (is_dead) begin
                //             next_state = DIE;
                //         end
                //         else if (is_damaged) begin
                //             next_state = DAMAGE;
                //         end
                //         else if (((keycode == 8'h1A && is_inhaled == 0) || (keycode == 8'h09 && is_inhaled == 1)) begin
                //             next_state = JUMP;
                //         end
                //         else if (keycode == 8'h16) begin
                //             next_state = SQUAT;
                //         end
                //         else if (keycode == 8'h04) begin
                //             next_state = LEFT_MOVE;
                //         end
                //         else if (keycode == 8'h07) begin
                //             next_state = RIGHT_MOVE;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 1) begin
                //             next_state = SPIT;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 0) begin
                //             next_state = INHALE;
                //         end
                //         else begin
                //             next_state = STAND;
                //         end
                //     end
                // JUMP:
                //     begin
                //         if (is_dead) begin
                //             next_state = DIE;
                //         end
                //         else if (is_damaged) begin
                //             next_state = DAMAGE;
                //         end
                //         else if (((keycode == 8'h1A && is_inhaled == 0) || (keycode == 8'h09 && is_inhaled == 1)) begin
                //             next_state = JUMP;
                //         end
                //         else if (keycode == 8'h16) begin
                //             next_state = SQUAT;
                //         end
                //         else if (keycode == 8'h04) begin
                //             next_state = LEFT_MOVE;
                //         end
                //         else if (keycode == 8'h07) begin
                //             next_state = RIGHT_MOVE;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 1) begin
                //             next_state = SPIT;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 0) begin
                //             next_state = INHALE;
                //         end
                //         else begin
                //             next_state = STAND;
                //         end
                //     end
                // SQUAT:
                //     begin
                //         if (is_dead) begin
                //             next_state = DIE;
                //         end
                //         else if (is_damaged) begin
                //             next_state = DAMAGE;
                //         end
                //         else if (((keycode == 8'h1A && is_inhaled == 0) || (keycode == 8'h09 && is_inhaled == 1)) begin
                //             next_state = JUMP;
                //         end
                //         else if (keycode == 8'h16) begin
                //             next_state = SQUAT;
                //         end
                //         else if (keycode == 8'h04) begin
                //             next_state = LEFT_MOVE;
                //         end
                //         else if (keycode == 8'h07) begin
                //             next_state = RIGHT_MOVE;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 1) begin
                //             next_state = SPIT;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 0) begin
                //             next_state = INHALE;
                //         end
                //         else begin
                //             next_state = STAND;
                //         end
                //     end
                // INHALE:
                //     begin
                //         if (is_dead) begin
                //             next_state = DIE;
                //         end
                //         else if (is_damaged) begin
                //             next_state = DAMAGE;
                //         end
                //         else if (((keycode == 8'h1A && is_inhaled == 0) || (keycode == 8'h09 && is_inhaled == 1)) begin
                //             next_state = JUMP;
                //         end
                //         else if (keycode == 8'h16) begin
                //             next_state = EAT;
                //         end
                //         else if (keycode == 8'h04) begin
                //             next_state = LEFT_MOVE;
                //         end
                //         else if (keycode == 8'h07) begin
                //             next_state = RIGHT_MOVE;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 1) begin
                //             next_state = SPIT;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 0) begin
                //             next_state = INHALE;
                //         end
                //         else begin
                //             next_state = STAND;
                //         end
                //     end
                // SPIT:
                //     begin
                //         if (is_dead) begin
                //             next_state = DIE;
                //         end
                //         else if (is_damaged) begin
                //             next_state = DAMAGE;
                //         end
                //         else if (((keycode == 8'h1A && is_inhaled == 0) || (keycode == 8'h09 && is_inhaled == 1)) begin
                //             next_state = JUMP;
                //         end
                //         else if (keycode == 8'h16) begin
                //             next_state = SQUAT;
                //         end
                //         else if (keycode == 8'h04) begin
                //             next_state = LEFT_MOVE;
                //         end
                //         else if (keycode == 8'h07) begin
                //             next_state = RIGHT_MOVE;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 1) begin
                //             next_state = SPIT;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 0) begin
                //             next_state = INHALE;
                //         end
                //         else begin
                //             next_state = STAND;
                //         end
                //     end
                // DAMAGE:
                //     begin
                //         if (is_dead) begin
                //             next_state = DIE;
                //         end
                //         else if (is_damaged) begin
                //             next_state = DAMAGE;
                //         end
                //         else if (((keycode == 8'h1A && is_inhaled == 0) || (keycode == 8'h09 && is_inhaled == 1)) begin
                //             next_state = JUMP;
                //         end
                //         else if (keycode == 8'h16) begin
                //             next_state = SQUAT;
                //         end
                //         else if (keycode == 8'h04) begin
                //             next_state = LEFT_MOVE;
                //         end
                //         else if (keycode == 8'h07) begin
                //             next_state = RIGHT_MOVE;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 1) begin
                //             next_state = SPIT;
                //         end
                //         else if (keycode == 8'h10 && is_inhaled == 0) begin
                //             next_state = INHALE;
                //         end
                //         else begin
                //             next_state = STAND;
                //         end
                //     end
                // DIE:
                //     begin
                //         next_state = STAND;
                //     end
                //     default: ;
            INI:
                begin
                    next_state = STAND0;
                end
            STAND0:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND1;
                    end
                end
            STAND1:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            RIGHT_MOVE0:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE1;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            RIGHT_MOVE1:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE2;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            RIGHT_MOVE2:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE3;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            RIGHT_MOVE3:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE4;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            RIGHT_MOVE4:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE5;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            RIGHT_MOVE5:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE6;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            RIGHT_MOVE6:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE7;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            RIGHT_MOVE7:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE8;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            RIGHT_MOVE8:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE9;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            RIGHT_MOVE9:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            LEFT_MOVE0:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE1;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            LEFT_MOVE1:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE2;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            LEFT_MOVE2:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE3;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            LEFT_MOVE3:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE4;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            LEFT_MOVE4:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE5;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            LEFT_MOVE5:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE6;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            LEFT_MOVE6:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE7;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            LEFT_MOVE7:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE8;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            LEFT_MOVE8:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE9;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
            LEFT_MOVE9:
                begin
                    if (keycode == 8'h07) begin
                        next_state = RIGHT_MOVE0;
                    end
                    else if (keycode == 8'h04) begin
                        next_state = LEFT_MOVE0;
                    end
                    else begin
                        next_state = STAND0;
                    end
                end
        endcase


        case (curr_state)
            //
                // STAND:
                //     begin
                //         character_frame = 4'b0000;
                //     end
                // RIGHT_MOVE:
                //     begin
                //         character_frame = 4'b0001;
                //     end
                // LEFT_MOVE:
                //     begin
                //         character_frame = 4'b0010;
                //     end
                // JUMP:
                //     begin
                //         character_frame = 4'b0011;
                //     end
                // SQUAT: //蹲
                //     begin
                //         character_frame = 4'b0100;
                //     end
                // INHALE:
                //     begin
                //         is_inhaled = 1'b1;
                //         character_frame = 4'b0101;
                //     end
                // SPIT: //吐
                //     begin
                //         is_inhaled = 1'b0;
                //         character_frame = 4'b0110;
                //     end
                // DAMAGE:
                //     begin
                //         health -= 1;
                //         if (health <= 0) begin
                //             is_dead = 1'b1;
                //         end
                //         character_frame = 4'b0111;
                //     end
                // DIE:
                //     begin
                //         game_over = 1'b1;
                //         character_frame = 4'b1000;
                //     end
            INI:
                begin
                    character_action_idx = 3'd0;
                    character_action_frame_idx = 4'd0;
                end
            STAND0:
                begin
                    character_action_idx = 3'd0;
                    character_action_frame_idx = 4'd0;
                end
            STAND1:
                begin
                    character_action_idx = 3'd0;
                    character_action_frame_idx = 4'd1;
                end
            RIGHT_MOVE0:
                begin
                    character_action_idx = 3'd1;
                    character_action_frame_idx = 4'd0;
                end
            RIGHT_MOVE1:
                begin
                    character_action_idx = 3'd1;
                    character_action_frame_idx = 4'd1;
                end
            RIGHT_MOVE2:
                begin
                    character_action_idx = 3'd1;
                    character_action_frame_idx = 4'd2;
                end
            RIGHT_MOVE3:
                begin
                    character_action_idx = 3'd1;
                    character_action_frame_idx = 4'd3;
                end
            RIGHT_MOVE4:
                begin
                    character_action_idx = 3'd1;
                    character_action_frame_idx = 4'd4;
                end
            RIGHT_MOVE5:
                begin
                    character_action_idx = 3'd1;
                    character_action_frame_idx = 4'd5;
                end
            RIGHT_MOVE6:
                begin
                    character_action_idx = 3'd1;
                    character_action_frame_idx = 4'd6;
                end
            RIGHT_MOVE7:
                begin
                    character_action_idx = 3'd1;
                    character_action_frame_idx = 4'd7;
                end
            RIGHT_MOVE8:
                begin
                    character_action_idx = 3'd1;
                    character_action_frame_idx = 4'd8;
                end
            RIGHT_MOVE9:
                begin
                    character_action_idx = 3'd1;
                    character_action_frame_idx = 4'd9;
                end
            LEFT_MOVE0:
                begin
                    character_action_idx = 3'd2;
                    character_action_frame_idx = 4'd0;
                end
            LEFT_MOVE1:
                begin
                    character_action_idx = 3'd2;
                    character_action_frame_idx = 4'd1;
                end
            LEFT_MOVE2:
                begin
                    character_action_idx = 3'd2;
                    character_action_frame_idx = 4'd2;
                end
            LEFT_MOVE3:
                begin
                    character_action_idx = 3'd2;
                    character_action_frame_idx = 4'd3;
                end
            LEFT_MOVE4:
                begin
                    character_action_idx = 3'd2;
                    character_action_frame_idx = 4'd4;
                end
            LEFT_MOVE5:
                begin
                    character_action_idx = 3'd2;
                    character_action_frame_idx = 4'd5;
                end
            LEFT_MOVE6:
                begin
                    character_action_idx = 3'd2;
                    character_action_frame_idx = 4'd6;
                end
            LEFT_MOVE7:
                begin
                    character_action_idx = 3'd2;
                    character_action_frame_idx = 4'd7;
                end
            LEFT_MOVE8:
                begin
                    character_action_idx = 3'd2;
                    character_action_frame_idx = 4'd8;
                end
            LEFT_MOVE9:
                begin
                    character_action_idx = 3'd2;
                    character_action_frame_idx = 4'd9;
                end
            default: ;
        endcase
    end

endmodule
