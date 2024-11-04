// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package custom_axi_ip_reg_pkg;

  // Address widths within the block
  parameter int BlockAw = 4;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////

  typedef struct packed {
    logic [31:0] q;
  } custom_axi_ip_reg2hw_din_reg_t;

  typedef struct packed {
    logic        q;
  } custom_axi_ip_reg2hw_enable_reg_t;

  typedef struct packed {
    logic [31:0] d;
  } custom_axi_ip_hw2reg_dout_reg_t;

  typedef struct packed {
    logic        d;
    logic        de;
  } custom_axi_ip_hw2reg_enable_reg_t;

  typedef struct packed {
    logic [1:0]  d;
  } custom_axi_ip_hw2reg_status_reg_t;

  // Register -> HW type
  typedef struct packed {
    custom_axi_ip_reg2hw_din_reg_t din; // [32:1]
    custom_axi_ip_reg2hw_enable_reg_t enable; // [0:0]
  } custom_axi_ip_reg2hw_t;

  // HW -> register type
  typedef struct packed {
    custom_axi_ip_hw2reg_dout_reg_t dout; // [35:4]
    custom_axi_ip_hw2reg_enable_reg_t enable; // [3:2]
    custom_axi_ip_hw2reg_status_reg_t status; // [1:0]
  } custom_axi_ip_hw2reg_t;

  // Register offsets
  parameter logic [BlockAw-1:0] CUSTOM_AXI_IP_DIN_OFFSET = 4'h 0;
  parameter logic [BlockAw-1:0] CUSTOM_AXI_IP_DOUT_OFFSET = 4'h 4;
  parameter logic [BlockAw-1:0] CUSTOM_AXI_IP_ENABLE_OFFSET = 4'h 8;
  parameter logic [BlockAw-1:0] CUSTOM_AXI_IP_STATUS_OFFSET = 4'h c;

  // Reset values for hwext registers and their fields
  parameter logic [31:0] CUSTOM_AXI_IP_DOUT_RESVAL = 32'h 0;
  parameter logic [1:0] CUSTOM_AXI_IP_STATUS_RESVAL = 2'h 0;

  // Register index
  typedef enum int {
    CUSTOM_AXI_IP_DIN,
    CUSTOM_AXI_IP_DOUT,
    CUSTOM_AXI_IP_ENABLE,
    CUSTOM_AXI_IP_STATUS
  } custom_axi_ip_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] CUSTOM_AXI_IP_PERMIT [4] = '{
    4'b 1111, // index[0] CUSTOM_AXI_IP_DIN
    4'b 1111, // index[1] CUSTOM_AXI_IP_DOUT
    4'b 0001, // index[2] CUSTOM_AXI_IP_ENABLE
    4'b 0001  // index[3] CUSTOM_AXI_IP_STATUS
  };

endpackage