#include <custom_axi_ip.h>
#include <stdio.h>
#include <stdint.h>

void write_data(uint32_t *din);
void read_data(uint32_t *dout);
void enable();
void wait();
void start_test (uint32_t din[1], uint32_t dout[1]);