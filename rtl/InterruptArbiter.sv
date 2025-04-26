/*
 * Copyright (C) 2025 Ramakrishna Kanungo
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met: redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer;
 * redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution;
 * neither the name of the copyright holders nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 */


module InterruptArbiter (
    input   logic                               CLK,
    input   logic                               RST,
    input   logic [NUM_INT_PORTS-1:0]           IRQ,
    output  logic                               IRQ_VLD
    output  logic [clog2(NUM_INT_PORTS)-1:0]    IRQ_ID
);


logic [NUM_INT_PORTS-1:0] InterruptSent, NextInterruptSent, SetInterruptSent, RstInterruptSent;

always_ff @(posedge CLK) begin
    if (RST) begin
        InterruptSent <= '0;
    end else begin
        InterruptSent <= NextInterruptSent;
    end
end

assign NextInterruptSent = SetInterruptSent & ~RstInterruptSent;

always_comb begin
    for(int p=0; p<NUM_INT_PORTS; p++) begin
        SetInterruptSent = (IRQ_ID == p) ? IRQ_VLD : 0;
        RstInterruptSent = ~IRQ[p];
    end
end

always_comb begin
    IRQ_VLD = '0;
    IRQ_ID  = '0;
    for(int p=0; p<NUM_INT_PORTS; p++) begin
        IRQ_VLD = ~InterruptSent[p] & IRQ[p];
        IRQ_ID  = p;
    end
end

endmodule