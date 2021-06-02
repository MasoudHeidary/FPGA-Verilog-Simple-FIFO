`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: MasoudHeidaryDeveloper@gmail.com
// License: MIT
// 
// Create Date:    10:02:37 05/31/2021 
// Design Name: 
// Module Name:    FIFO 
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
module FIFO
//module parameters
#(
    parameter Depth = 8,
    parameter Width = 8
)
//ports
(
    input [Width-1 : 0] DataI,
    output reg [Width-1 : 0] DataO,
    output reg FF,  //full flag
    output reg EF,  //empty falg
    input R,    //read
    input W,    //write
    input clk
);

//pointers
    reg [$clog2(Depth)-1 : 0] _write_pointer = 0;
    reg [$clog2(Depth)-1 : 0] _read_pointer = 0;

//memory
    reg [Width-1 : 0] _memory[Depth-1: 0];

    always @(posedge clk)
    begin
        DataO <= 'bZ;
        EF <= 0;
        FF = 0;
        // ----------------------------------------------- read from FIFO
        if (R)
        begin
            if(_read_pointer != _write_pointer)
            begin
                DataO <= _memory[_read_pointer];
                _read_pointer <= _read_pointer + 1;
                if (_read_pointer == Depth)
                    _read_pointer <= 0;
            end
            else
            begin
                EF <= 1;    
            end
            $display("FIFO read: EF:%d, Data:%d, Pointer:%d",
            EF,
            _memory[_read_pointer],
            _read_pointer
            );
        end
        // END----------------------------------------------- read from FIFO
        // ----------------------------------------------- write to FIFO
        else if (W) 
        begin
            if(_write_pointer != Depth-1)
            begin
                if(_write_pointer+1 == _read_pointer)
                    FF = 1;
            end
            else if (_read_pointer == 0)
            begin
                FF = 1;
            end

            // if no error occur write data 
            if (!FF)
            begin
                _memory[_write_pointer] <= DataI;
                _write_pointer <= _write_pointer + 1;
                if (_write_pointer == Depth)
                begin
                    _write_pointer <= 0;
                end
            end
            $display("FIFO write: FF:%d, Data:%d, Pointer:%d",
            FF,
            DataI,
            _write_pointer
            );
        end
        // END----------------------------------------------- write to FIFO
    end
endmodule
