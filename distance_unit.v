`timescale 1ns / 1ps

module distance_unit #(
    parameter WIDTH  = 8,
    // FIX: DISTW must accommodate (WIDTH+1)-bit signed squares summed together.
    // dx, dy are WIDTH+1 bits; dx*dx is 2*(WIDTH+1) bits; sum needs one more bit.
    parameter DISTW  = 2*(WIDTH+1) + 1   // was: 2*WIDTH+1 = 17, now 19 for WIDTH=8
)(
    input  wire [WIDTH-1:0] x,
    input  wire [WIDTH-1:0] y,
    input  wire [WIDTH-1:0] cx,
    input  wire [WIDTH-1:0] cy,
    output wire [DISTW-1:0] dist
);
    wire signed [WIDTH:0]    dx;
    wire signed [WIDTH:0]    dy;
    wire signed [2*WIDTH+1:0] dx_sq;
    wire signed [2*WIDTH+1:0] dy_sq;

    assign dx    = $signed({1'b0, x}) - $signed({1'b0, cx});
    assign dy    = $signed({1'b0, y}) - $signed({1'b0, cy});
    assign dx_sq = dx * dx;
    assign dy_sq = dy * dy;

    assign dist  = dx_sq + dy_sq;
endmodule