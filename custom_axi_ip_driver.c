#include <stdio.h>
#include <stdint.h>
#include <custom_axi_ip_driver.h>
#include <custom_axi_ip.h>

#define BASE_ADDR 0x1A1400000

void write_data(uint32_t *din) {
    uint32_t volatile *reg = (uint32_t *)(BASE_ADDR + CUSTOM_AXI_IP_DIN_REG_OFFSET);
    reg = din;
    // reg[0] = din[0];
}

void read_data(uint32_t *dout) {
    uint32_t volatile *reg = (uint32_t *)(BASE_ADDR + CUSTOM_AXI_IP_DOUT_REG_OFFSET);
    *dout = *reg;
}

void enable() {
    uint32_t volatile *reg = (uint32_t *)(BASE_ADDR + CUSTOM_AXI_IP_ENABLE_REG_OFFSET);
    *reg = 1;
}

void wait() {
    uint32_t volatile *reg = (uint32_t *)(BASE_ADDR + CUSTOM_AXI_IP_STATUS_REG_OFFSET);
    uint32_t status;
    do {
        status = *reg;
    } while (status != CUSTOM_AXI_IP_STATUS_STATUS_VALUE_IDLE);
}

void start_test (uint32_t din[1], uint32_t dout[1]) {
    printf("Starting test in driver");
    write_data(din);
    enable();
    wait();
    read_data(dout);
}