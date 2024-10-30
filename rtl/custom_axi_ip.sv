module custom_axi_ip
  import custom_axi_ip_pkg::status_e;
#(
    parameter DATA_WIDTH = 32
) (
    input logic clk_i,
    input logic rst_ni,

    // Register to Hardware interface
    input logic [15:0] din,
    input logic enable_in,
    output logic [16:0] dout,
    output logic [1:0] enable_out,
    output logic [2:0] status_out
);
  // Register to hold input data
  logic [15:0] internal_data;
  status_e state;

  always_ff @(posedge clk_i) begin
    if (!rst_ni) begin
      internal_data <= 16'b0;
      state <= custom_axi_ip_pkg::IDLE;
      dout <= 17'b0;
      enable_out <= 2'b0;
      status_out <= 3'b0;
    end else begin
      case (state)
        custom_axi_ip_pkg::IDLE: begin
          if (enable_in) begin
            $display("Idle state");
            $display("DIN: %x", din); 
            internal_data <= din;
            // if (internal_data != 32'h0) begin
            //   state <= custom_axi_ip_pkg::BUSY;
            // end
          end else begin
            state <= custom_axi_ip_pkg::IDLE;
          end

          dout <= 17'b0;
          enable_out <= 2'b0;
        end
        custom_axi_ip_pkg::BUSY: begin
          // status_out <= custom_axi_ip_pkg::BUSY;
          $display("Busy state");
          $display("Internal data before: %x", internal_data);
          internal_data <= internal_data + 1'b1;
          $display("Internal data after: %x", internal_data);
          state <= custom_axi_ip_pkg::DONE;
          dout <= 17'b0;
          enable_out <= 2'b0;
        end
        custom_axi_ip_pkg::DONE: begin
          // status_out <= custom_axi_ip_pkg::DONE;
          $display("Done state");
          dout <= {internal_data, 1'b1};
          $display("DOUT: %x", dout);
          enable_out <= 2'b01;
          state <= custom_axi_ip_pkg::IDLE;
        end
        custom_axi_ip_pkg::ERROR: begin
          // status_out <= custom_axi_ip_pkg::ERROR;
          $display("Error state");
          state <= custom_axi_ip_pkg::IDLE;
          dout <= 17'b0;
          enable_out <= 2'b0;
        end
        default: begin
          state <= custom_axi_ip_pkg::ERROR;
          dout <= 17'b0;
          enable_out <= 2'b0;
        end
      endcase
      status_out <= {state,1'b1};
    end
  end

endmodule
