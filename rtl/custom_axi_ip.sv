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
    ouput logic [31:0] ipreg_data_out,
    ouput logic enable_out,
    output status_e status_out
);
  // Register to hold input data
  logic [31:0] internal_data;
  status_e current_state, next_state;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      internal_data <= 32'b0;
      current_state <= custom_axi_ip_pkg::IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    case (current_state)
      custom_axi_ip_pkg::IDLE: begin
        $display("Idle state but not enabled");
        if (enable_in) begin
          $display("Idle state");
          internal_data <= ipreg_data;
          next_state <= custom_axi_ip_pkg::BUSY;
        end
      end
      custom_axi_ip_pkg::BUSY: begin
        $display("Busy state");
        internal_data <= internal_data + 1;
        next_state <= custom_axi_ip_pkg::DONE;
      end
      custom_axi_ip_pkg::DONE: begin
        $display("Done state");
        ipreg_data_out <= internal_data;
        enable_out <= 1'b0;
        next_state <= custom_axi_ip_pkg::IDLE;
      end
      custom_axi_ip_pkg::ERROR: begin
        $display("Error state");
        ipreg_data_out <= 32'b0;
        enable_out <= 1'b0;
        next_state <= custom_axi_ip_pkg::IDLE;
      end
      default: begin
        next_state <= current_state;
      end
    endcase
  end

  assign status_out = current_state;

endmodule
