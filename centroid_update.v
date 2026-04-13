`timescale 1ns / 1ps

module centroid_update #(
    parameter WIDTH = 8,
    parameter SUMW  = 24
)(
    input  wire              clk,
    input  wire              rst,
    input  wire              clear,
    input  wire              point_valid,
    input  wire [WIDTH-1:0]  px,
    input  wire [WIDTH-1:0]  py,
    output reg  [SUMW-1:0]   sum_x,
    output reg  [SUMW-1:0]   sum_y,
    output reg  [SUMW-1:0]   count,
    // FIX: centroid outputs are now wires driven combinationally
    output wire [WIDTH-1:0]  centroid_x,
    output wire [WIDTH-1:0]  centroid_y
);
    // FIX Bug 1 & 2: Division moved here — purely combinational, outside the always block.
    // FIX Bug 2: Guard against count==0 to avoid divide-by-zero on the very first cycle.
    assign centroid_x = (count != 0) ? sum_x / count : 0;
    assign centroid_y = (count != 0) ? sum_y / count : 0;

    // Accumulator — only addition, fully synthesizable
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sum_x <= 0;
            sum_y <= 0;
            count <= 0;
        end else if (clear) begin
            sum_x <= 0;
            sum_y <= 0;
            count <= 0;
        end else if (point_valid) begin
            sum_x <= sum_x + px;
            sum_y <= sum_y + py;
            count <= count + 1;
        end
    end
endmodule