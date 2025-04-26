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


interface interrupt_arbiter_top_if
(
    logic                               CLK,
    logic                               RST,
    logic [NUM_INT_PORTS-1:0]           IRQ,
    logic                               IRQ_VLD
    logic [clog2(NUM_INT_PORTS)-1:0]    IRQ_ID
)

import InterruptArbiterPkg::*;


default clocking mon_cb @(posedge CLK);
    input CLK;
    input RST;
    input IRQ;
    input IRQ_VLD;
    input IRQ_ID;
endclocking : mon_cb

clocking drv_cb @(posedge CLK);
    output RST;
    output IRQ;
endclocking: drv_cb


endinterface : interrupt_arbiter_top_if
