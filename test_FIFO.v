`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MasoudHeidaryDeveloper@gmail.com
// license: MIT
// 
// Create Date:    10:02:55 05/31/2021 
// Design Name: 
// Module Name:    test_FIFO 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module test_FIFO(
    );

    reg [7:0] _data_send;
    wire [7:0] _data_rec;
    wire _FF;
    wire _EF;
    reg _R = 0;
    reg _W = 0;

    reg clk = 0;
    always #5 clk <= !clk;

    FIFO #(.Depth(8))
    ut(
        .DataI(_data_send),
        .DataO(_data_rec),
        .FF(_FF),
        .EF(_EF),
        .R(_R),
        .W(_W),
        .clk(clk)
    );

    integer i;
    initial
    begin
        _W <= 1;
        _R <= 0;
    // ----------------------------------- write to FIFO
        for(i=0; i<10; i=i+1)
        begin
            _data_send <= $random;
            #10;
            $display("FF:%d, Data:%d", _FF, _data_send);
        end

        _W <= 0;
        _R <= 1;
    // ----------------------------------- read from FIFO
        for(i=0; i<10; i=i+1)
        begin
            #10;
            $display("EF:%d, Data:%d", _EF, _data_rec);
        end
    end
endmodule