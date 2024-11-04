module custom_axi_ip
  import custom_axi_ip_pkg::status_e;
#(
    parameter DATA_WIDTH = 32
) (
    input logic clk_i,
    input logic rst_ni,

    // Register to Hardware interface
    input logic [31:0] din,
    input logic enable_in,
    output logic [31:0] dout,
    output logic [1:0] enable_out,
    output logic [1:0] status_out
);
  // Register to hold input data
  logic [31:0] internal_data;
  status_e state;
  logic done_add = 0;
  logic done_read = 0;

  always_ff @(posedge clk_i) begin
    if (!rst_ni) begin
      internal_data <= 32'b0;
      state <= custom_axi_ip_pkg::IDLE;
      dout <= 32'b0;
      enable_out <= 2'b0;
      status_out <= 2'b0;
    end else begin
      case (state)
        custom_axi_ip_pkg::IDLE: begin
          if (enable_in) begin
            $display("Idle state");
            internal_data <= din;
            done_read <= 1'b1;
            state <= custom_axi_ip_pkg::BUSY;
          end else begin
            state <= custom_axi_ip_pkg::IDLE;
          end
        end
        custom_axi_ip_pkg::BUSY: begin
          // status_out <= custom_axi_ip_pkg::BUSY;
          $display("Busy state");
          internal_data <= internal_data + 32'b1;
          state <= custom_axi_ip_pkg::DONE;
          // dout <= 16'b0;
          // enable_out <= 2'b01;
        end
        custom_axi_ip_pkg::DONE: begin
          // status_out <= custom_axi_ip_pkg::DONE;
          $display("Done state");
          done_add <= 1'b1;
          // dout <= internal_data;
          // $display("DOUT: %x", dout);
          // enable_out <= 2'b01;
          state <= custom_axi_ip_pkg::IDLE;
        end
        custom_axi_ip_pkg::ERROR: begin
          // status_out <= custom_axi_ip_pkg::ERROR;
          $display("Error state");
          state <= custom_axi_ip_pkg::IDLE;
          // dout <= 16'b0;
          // enable_out <= 2'b00;
        end
        default: begin
          state <= custom_axi_ip_pkg::ERROR;
          // dout <= 16'b0;
          // enable_out <= 2'b00;
        end
      endcase
      if (done_read) begin
        done_read <= 1'b0;
        enable_out <= 2'b01;
      end
      
      if (done_add) begin
        done_add <= 1'b0;
        dout <= internal_data;
      end
      
      status_out <= state;
    end
  end

endmodule
