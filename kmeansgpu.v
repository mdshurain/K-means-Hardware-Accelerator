`timescale 1ns / 1ps

module kmeansgpu  #(
    parameter WIDTH = 8,
    // FIX: Match the corrected DISTW from distance_unit — 2*(WIDTH+1)+1
    parameter DISTW = 2*(WIDTH+1) + 1,   // was: 2*WIDTH+1
    parameter IDW   = 2
)(
    input  wire [WIDTH-1:0] x,
    input  wire [WIDTH-1:0] y,

    input  wire [WIDTH-1:0] c0x, c0y,
    input  wire [WIDTH-1:0] c1x, c1y,
    input  wire [WIDTH-1:0] c2x, c2y,

    output wire [DISTW-1:0] min_dist,
    output wire [IDW-1:0]   cluster_id,
    output wire [DISTW-1:0] dist0,
    output wire [DISTW-1:0] dist1,
    output wire [DISTW-1:0] dist2
);
    wire [DISTW-1:0] d0, d1, d2;
    wire [DISTW-1:0] m01_dist;
    wire [IDW-1:0]   m01_id;

    distance_unit #(.WIDTH(WIDTH), .DISTW(DISTW)) u0 (
        .x(x), .y(y), .cx(c0x), .cy(c0y), .dist(d0)
    );
    distance_unit #(.WIDTH(WIDTH), .DISTW(DISTW)) u1 (
        .x(x), .y(y), .cx(c1x), .cy(c1y), .dist(d1)
    );
    distance_unit #(.WIDTH(WIDTH), .DISTW(DISTW)) u2 (
        .x(x), .y(y), .cx(c2x), .cy(c2y), .dist(d2)
    );

    min2_with_id #(.DISTW(DISTW), .IDW(IDW)) cmp01 (
        .dist_a(d0), .id_a(2'd0),
        .dist_b(d1), .id_b(2'd1),
        .min_dist(m01_dist), .min_id(m01_id)
    );
    min2_with_id #(.DISTW(DISTW), .IDW(IDW)) cmp02 (
        .dist_a(m01_dist), .id_a(m01_id),
        .dist_b(d2),       .id_b(2'd2),
        .min_dist(min_dist), .min_id(cluster_id)
    );

    assign dist0 = d0;
    assign dist1 = d1;
    assign dist2 = d2;
endmodule