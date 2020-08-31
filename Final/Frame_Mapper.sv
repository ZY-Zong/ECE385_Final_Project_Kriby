module frame_kirby(
        input  [2:0]  character_action_idx, // which action
		input  [3:0]  character_action_frame_idx,
        output [9:0]  kirby_LU_X, kirby_LU_Y, kirby_center_X, kirby_center_Y);
        //width = 28, height = 28
    parameter [0:3-1][9:0] frame_number = {
        10'd2, 10'd10, 10'd10
    };
    parameter [0:3-1][9:0] first_frame_center_X = {
        10'd12, 10'd12, 10'd15
    };
    parameter [0:3-1][9:0] first_frame_center_Y = {
        10'd19, 10'd47, 10'd75
    };
    
    assign kirby_LU_X = character_action_frame_idx * 28;
    assign kirby_LU_Y = character_action_idx * 28;
    assign kirby_center_X = first_frame_center_X[character_action_idx] + character_action_frame_idx * 28;
    assign kirby_center_Y = first_frame_center_Y[character_action_idx];

endmodule

// module frame_height_kirby(
//         input  [2:0]  character_action_idx, // which action
// 		input  [3:0]  character_action_frame_idx,
//         output [9:0]  kirby_height);
//     parameter [0:1][9:0] height_kirby = {
//         10'd18, 10'd18, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0,
//         10'd19, 10'd18, 10'd16, 

//     };

//     assign kirby_height = width_kirby[character_action_idx * 10 + character_action_frame_idx];

// endmodule


// module frame_LU_kirby(
//         input  [2:0]  character_action_idx, // which action
// 		input  [3:0]  character_action_frame_idx,
//         output [9:0]  kirby_LU_X,
//         output [9:0]  kirby_LU_Y);
//     parameter [0:1][9:0] LU_X_kirby = {
//         10'd6, 10'd30, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0,
//         10'd6, 10'd31, 10'd

//     };
//     parameter [0:1][9:0] LU_Y_kirby = {
//         10'd9, 10'd9, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0, 10'd0,
//         10'd58, 10'd59
//     };

//     assign kirby_LU_X = LU_X_kirby[character_action_idx * 10 + character_action_frame_idx];
//     assign kirby_LU_Y = LU_Y_kirby[character_action_idx * 10 + character_action_frame_idx];

// endmodule