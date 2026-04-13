`timescale 1ns / 1ps

module min2_with_id #(
    parameter DISTW = 17,
    parameter IDW   = 2
)(
    input  wire [DISTW-1:0] dist_a,
    input  wire [IDW-1:0]   id_a,
    input  wire [DISTW-1:0] dist_b,
    input  wire [IDW-1:0]   id_b,
    output reg  [DISTW-1:0] min_dist,
    output reg  [IDW-1:0]   min_id
);
    always @(*) begin
        if (dist_a <= dist_b) begin
            min_dist = dist_a;
            min_id   = id_a;
        end else begin
            min_dist = dist_b;
            min_id   = id_b;
        end
    end
endmodule
