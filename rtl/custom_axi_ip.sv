module custom_axi_ip 
  import custom_axi_ip_pkg::status_e;
  #(
    parameter DATA_WIDTH = 32
) (
    input logic clk_i,
    input logic rst_ni,

    // Register to Hardware interface
    input logic [31:0] ipreg_data,
    input logic enable_in,
    output logic [31:0] ipreg_data_out,
    output logic enable_out,
    output status_e [1:0] status_out
);
  // Register to hold input data
  logic [31:0] internal_data;
  status_e current_state, next_state;
  logic [2:0] check;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      internal_data <= 32'b0;
      current_state <= custom_axi_ip_pkg::IDLE;
      check <= 3'b000;
    end else begin
      current_state <= next_state;
    end
  end

  always_ff @(posedge clk_i) begin
    if (check < 3'b111) begin
      check <= check + 1;
      $display("Check: %0d", check);
      $display("State: %0d, Enable: %h, Input data: %h", current_state, enable_in, ipreg_data);
    end
    case (current_state)
      custom_axi_ip_pkg::IDLE: begin
        if (enable_in) begin
          $display("Idle state");
          internal_data <= ipreg_data;
          next_state <= custom_axi_ip_pkg::BUSY;
          enable_out <= 1'b0;
        end else begin
          next_state <= custom_axi_ip_pkg::IDLE;
          ipreg_data_out <= ipreg_data;
          enable_out <= enable_in;
        end
      end
      custom_axi_ip_pkg::BUSY: begin
        $display("Busy state");
        internal_data <= internal_data + 1;
        next_state <= custom_axi_ip_pkg::DONE;
        enable_out <= 1'b0;
      end
      custom_axi_ip_pkg::DONE: begin
        $display("Done state");
        ipreg_data_out <= internal_data;
        enable_out <= 1'b0;
        next_state <= custom_axi_ip_pkg::IDLE;
      end
      custom_axi_ip_pkg::ERROR: begin
        $display("Error state");
        ipreg_data_out <= ipreg_data;
        enable_out <= enable_in;
        next_state <= custom_axi_ip_pkg::IDLE;
      end
      default: begin
        next_state <= custom_axi_ip_pkg::ERROR;
      end
    endcase
  end

  assign status_out = current_state;

endmodule
