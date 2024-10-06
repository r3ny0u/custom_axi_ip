package custom_axi_ip_pkg;
    
    typedef enum logic[1:0] {
        IDLE     = 0,
        BUSY     = 1,
        DONE     = 2,
        ERROR    = 3 
    } status_e;

endpackage : custom_axi_ip_pkg