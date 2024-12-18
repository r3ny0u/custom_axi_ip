// Generated register defines for custom_axi_ip

#ifndef _CUSTOM_AXI_IP_REG_DEFS_
#define _CUSTOM_AXI_IP_REG_DEFS_

#ifdef __cplusplus
extern "C" {
#endif
// Register width
#define CUSTOM_AXI_IP_PARAM_REG_WIDTH 32

// Data to be computed
#define CUSTOM_AXI_IP_DIN_REG_OFFSET 0x0

// Result
#define CUSTOM_AXI_IP_DOUT_REG_OFFSET 0x4

// Enable register
#define CUSTOM_AXI_IP_ENABLE_REG_OFFSET 0x8
#define CUSTOM_AXI_IP_ENABLE_ENABLE_BIT 0

// Status register
#define CUSTOM_AXI_IP_STATUS_REG_OFFSET 0xc
#define CUSTOM_AXI_IP_STATUS_STATUS_MASK 0x3
#define CUSTOM_AXI_IP_STATUS_STATUS_OFFSET 0
#define CUSTOM_AXI_IP_STATUS_STATUS_FIELD \
  ((bitfield_field32_t) { .mask = CUSTOM_AXI_IP_STATUS_STATUS_MASK, .index = CUSTOM_AXI_IP_STATUS_STATUS_OFFSET })
#define CUSTOM_AXI_IP_STATUS_STATUS_VALUE_IDLE 0x0
#define CUSTOM_AXI_IP_STATUS_STATUS_VALUE_BUSY 0x1
#define CUSTOM_AXI_IP_STATUS_STATUS_VALUE_DONE 0x2
#define CUSTOM_AXI_IP_STATUS_STATUS_VALUE_ERROR 0x3

#ifdef __cplusplus
}  // extern "C"
#endif
#endif  // _CUSTOM_AXI_IP_REG_DEFS_
// End generated register defines for custom_axi_ip
