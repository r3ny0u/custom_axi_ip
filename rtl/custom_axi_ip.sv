module custom_axi_ip
  import custom_axi_ip_pkg::status_e;
#(
    parameter DATA_WIDTH = 32
) (
    input logic clk_i,
    input logic rst_ni,

    // Register to Hardware interface
    input logic [63:0] ipreg_data,
    input logic enable_in,
    output logic [63:0] ipreg_data_out,
    output logic enable_out,
    output status_e status_out,
    output logic wen_out
);
  // Register to hold input data
  logic [63:0] internal_data;
  status_e state;

  always_ff @(posedge clk_i) begin
    if (!rst_ni) begin
      internal_data <= 64'b0;
      state <= custom_axi_ip_pkg::IDLE;
    end else begin
      case (state)
        custom_axi_ip_pkg::IDLE: begin
          wen_out <= 1'b0;
          status_out <= custom_axi_ip_pkg::IDLE;
          if (enable_in) begin
            $display("Idle state");
            internal_data <= ipreg_data;
            state <= custom_axi_ip_pkg::BUSY;
          end else begin
            state <= custom_axi_ip_pkg::IDLE;
          end
        end
        custom_axi_ip_pkg::BUSY: begin
          wen_out <= 1'b0;
          status_out <= custom_axi_ip_pkg::BUSY;
          $display("Busy state");
          internal_data[63:32] <= internal_data + 1;
          internal_data[31:0] <= internal_data + 1;
          $display("Internal data 1: %d", internal_datap[63:32]);
          $display("Internal data 2: %d", internal_datap[31:0]);
          state <= custom_axi_ip_pkg::DONE;
        end
        custom_axi_ip_pkg::DONE: begin
          wen_out <= 1'b1;
          status_out <= custom_axi_ip_pkg::DONE;
          $display("Done state");
          ipreg_data_out <= internal_data;
          enable_out <= 1'b0;
          state <= custom_axi_ip_pkg::IDLE;
        end
        custom_axi_ip_pkg::ERROR: begin
          wen_out <= 1'b0;
          status_out <= custom_axi_ip_pkg::ERROR;
          $display("Error state");
          state <= custom_axi_ip_pkg::IDLE;
        end
        default: begin
          state <= custom_axi_ip_pkg::ERROR;
        end
      endcase
    end
  end

endmodule
