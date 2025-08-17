`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2023 19:40:34
// Design Name: 
// Module Name: core
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module core(
    command,
    address,
    reset,
    int_out,
    int_clear,
    bus_data,
    address_latched,
    address_extension_latched,
    wait_cycles_latched,
    input_buf_mem_address,
    input_buf_mem_data,
    input_buf_mem_write,
    start,
    pause,
    clock,
    trigger_0,
    trigger_1,
    trigger_PS,
    trigger_out,
    condition_0,
    condition_1,
    condition_PS,
    latch_current_state,
    
    bus_clock_or_strobe,
    I2C_SCL,
    I2C_SDA,
    I2C_SELECT_0,
    I2C_SELECT_1,
    SPI_IN_0,
    SPI_IN_1,
    SPI_OUT,
    SPI_SCK,
    SPI_SELECT_0,
    SPI_SELECT_1,
    error_detected,
    last_DMA_memory_margin,
    running,
    options,
    clock_cycles_this_run,
    periodic_trigger_count, 
    waiting_for_periodic_trigger, 
    warning_missed_periodic_trigger,
    core_dig_in,
    secondary_PS_PL_interrupt,
    reset_secondary_PS_PL_interrupt,
    input_mem_PS_PL_interrupt,
    reset_input_mem_PS_PL_interrupt,
    adc_enable,
    adc_register_address,
    adc_conversion_start,
    adc_result_in,
    adc_write_enable,
    adc_programming_out,
    adc_ready,
    adc_channel,
    PL_to_PS_command,
    SPI_chip_select,
    periodic_trigger_signal
    );
    
    input [63:0] command;
    output reg [15:0] address = 0;
    input reset;
    output reg int_out;
    input int_clear;
    output reg [27:0] bus_data = 0;
    output reg [15:0] address_latched = 0;
    output reg [12:0] address_extension_latched = 0;
    output reg [47:0] wait_cycles_latched = 0;
    output reg [12:0] input_buf_mem_address = 0;
    output reg [31:0] input_buf_mem_data = 0;
    reg [31:0] input_buf_data_high_32_bit = 0;
    output reg input_buf_mem_write = 0;
    output reg [47:0] clock_cycles_this_run = 0;
    input start;
    input pause;
    input clock;
    input trigger_0;
    input trigger_1;
    input trigger_PS;
    output reg trigger_out = 0;
    input condition_0;
    input condition_1;
    input condition_PS;
    input latch_current_state;
    input SPI_IN_0;
    input SPI_IN_1;
    output reg SPI_OUT = 0;
    output reg bus_clock_or_strobe = 0;
    output reg I2C_SCL = 1;
    output reg I2C_SDA = 1;
    output reg I2C_SELECT_0;
    output reg I2C_SELECT_1;
    output reg SPI_SCK = 0;
    output reg SPI_SELECT_0;
    output reg SPI_SELECT_1;
    output reg error_detected;
    output reg [15:0] last_DMA_memory_margin;
    output reg [47:0] periodic_trigger_count;
    output reg waiting_for_periodic_trigger;
    output reg warning_missed_periodic_trigger;
    output reg running = 0;
    output reg [31:0] options = 0; 
    input reg [7:0] core_dig_in;
    output reg secondary_PS_PL_interrupt = 0;
    input reset_secondary_PS_PL_interrupt;
    output reg input_mem_PS_PL_interrupt = 0;
    input reset_input_mem_PS_PL_interrupt;
    output reg adc_enable = 0;
    output reg adc_conversion_start = 0;
    input [15:0] adc_result_in;
    output reg [6:0] adc_register_address = 0;
    output reg adc_write_enable = 0;
    output reg [15:0] adc_programming_out = 0;
    input adc_ready;
    input [4:0] adc_channel;
    output  reg [15:0] PL_to_PS_command = 0;
    output reg [3:0] SPI_chip_select = 'hF;


reg synchronous_reset = 0;
reg synchronous_reset_secondary_PS_PL_interrupt = 0;
reg synchronous_reset_input_mem_PS_PL_interrupt = 0;

reg int_clear_happened = 0 ;
reg reset_input_mem_PS_PL_interrupt_happened = 0;
reg [16:0] input_buf_mem_data_SPI = 0;
reg [12:0] address_extension = 0;
reg [47:0] wait_cycles = 0;
reg bus_clock = 0;
reg bus_strobe = 0;
reg [3:0] strobe_choice = 0; 
reg [7:0] strobe_delay = 0; 
reg [7:0] strobe_low_length = 0; 
reg [7:0] strobe_high_length = 0; 
reg [117:0] register = 0;
reg [63:0] command_buffer = 0;
reg [32:0] loop_count = 0;

reg [47:0] periodic_trigger_count_internal = 0;
reg [47:0] periodic_trigger_period = 0;  //FS; don't set this to zero when receiving a reset signal. Only program it through CMD_SET_PERIODIC_TRIGGER_PERIOD command
reg [47:0] periodic_trigger_allowed_wait_cycles = 0;
reg [47:0] periodic_trigger_wait_cycles = 0;
reg [55:0] cycle_count_since_startup = 0;
//only for debug
output reg periodic_trigger_signal = 0;
reg [15:0] ANA_OUT_VALUE = 0;
reg [15:0] ana_in_data = 0;
reg [4:0] ana_in_channel = 0;



always @(*)
begin
    case (strobe_choice)
    0: begin
        bus_clock_or_strobe <= bus_clock;
    end
    1: begin
       bus_clock_or_strobe <= bus_strobe;
    end
    2: begin
       bus_clock_or_strobe <= 0;
    end
    3: begin
       bus_clock_or_strobe <= 1;
    end
    4: begin
       bus_clock_or_strobe <= bus_data[27];
    end
    default: begin
        bus_clock_or_strobe <= bus_clock;
    end
    endcase
end         


enum logic [2:0] {PERIODIC_TRIGGER_IDLE,
                PERIODIC_TRIGGER_START,
                PERIODIC_TRIGGER_WAIT1,    
                PERIODIC_TRIGGER_WAIT2,    
                PERIODIC_TRIGGER_WAIT3,    
                PERIODIC_TRIGGER_WAIT4,    
                PERIODIC_TRIGGER_WAIT5,    
                PERIODIC_TRIGGER_STOP
                } PERIODIC_TRIGGER_state = PERIODIC_TRIGGER_IDLE;



enum logic [2:0] {I2C_IDLE,
            I2C_START,
            I2C_START_SCL_LOW,
            I2C_DATA_LOAD,
            I2C_CLOCK_HIGH,
            I2C_CLOCK_LOW,
            I2C_STOP,
            I2C_STOP_SCL_HIGH } I2C_state = I2C_IDLE;
 
reg [7:0] I2C_delay = 0;
reg [7:0] I2C_bit = 0;
reg [117:0] I2C_data = 0;
reg [7:0] I2C_length = 0;
reg [1:0] I2C_SELECT_NEXT = 0;

enum logic [3:0] {SPI_IDLE,
            SPI_START,
            SPI_SCL_LOW_DATA_OUT,
            SPI_SCL_HIGH_DATA_OUT,
            SPI_SCL_LOW_DATA_IN,
            SPI_SCL_LOW_DATA_IN_WAIT,
            SPI_SCL_HIGH_DATA_IN_WAIT,
            SPI_WRITE_TO_INPUT_MEMORY,
            SPI_STOP} SPI_state = SPI_IDLE;

reg [7:0] SPI_delay = 0;
reg [7:0] SPI_OUT_bit_nr = 0;
reg [6:0] SPI_IN_bit_nr = 0;
reg [117:0] SPI_data = 0;
reg [6:0] SPI_OUT_length = 0;
reg [5:0] SPI_IN_length = 0;
reg [1:0] SPI_SEL_next = 1;
reg [3:0] SPI_chip_select_next = 2+4+8;


enum logic [1:0] {ANA_IN_IDLE,
            ANA_IN_START,
            ANA_IN_TRIGGER_READ_WRITE,
            ANA_IN_INCREASE_INPUT_MEM_ADDRESS} ANA_IN_state = ANA_IN_IDLE;

reg [7:0] ANA_IN_delay = 0;
reg ana_in_data_expected = 0;

enum logic [2:0] {INPUT_MEM_IDLE,
                  INPUT_MEM_WRITE_64BIT,
                  INPUT_MEM_WRITE_2_64BIT,
                  INPUT_MEM_WRITE_3_64BIT,
                  INPUT_MEM_WRITE_4_64BIT,
                  INPUT_MEM_WRITE,
                  INPUT_MEM_WRITE_2,
                  INPUT_MEM_STOP} INPUT_MEM_state = INPUT_MEM_IDLE;


//every time the adc presents a new conversion result or a new register read output, store that data in our input buffer
//without the "posedge clock" the flipflops of ana_in_data_reg and ana_in_channel_reg don't get a clock input.
//always @(posedge clock, posedge adc_ready)
//begin
//    if (adc_ready) begin
 //       ana_in_data <= adc_result_in;
  //      ana_in_channel <= adc_channel;
  //  end
//end

//code that creates trouble:
//without the "posedge clock" the flipflops of ana_in_data_reg and ana_in_channel_reg don't get a clock input.

//always @(posedge adc_ready)
//begin
//    if (ana_in_data_expected) begin
//        ana_in_data <= adc_result_in;
//        ana_in_channel <= adc_channel;
//    end
//end


enum logic [0:0] {DIG_IN_IDLE,
            DIG_IN_START} DIG_IN_state = DIG_IN_IDLE;

enum logic [1:0] {INPUT_REPEAT_IDLE,
            INPUT_REPEAT_START,
            INPUT_REPEAT_WAIT} INPUT_REPEAT_state = INPUT_REPEAT_IDLE;

reg [23:0] INPUT_REPEAT_wait = 0;
reg [24:0] INPUT_REPEAT_delay = 0;
reg [19:0] INPUT_REPEAT_repeats = 0;
reg [20:0] INPUT_REPEAT_nr = 0;
reg INPUT_REPEAT_trigger_secondary_interrupt_when_finished = 0;
reg [2:0] INPUT_REPEAT_command = 0;


enum logic [1:0] {  STROBE_GEN_IDLE,
                    DELAY_CYCLE,
                    PULSE_CYCLE } strobe_generator_state = STROBE_GEN_IDLE;
            
typedef enum logic [4:0] {  CMD_STOP, //0
                            CMD_STEP, //1
                            CMD_STEP_AND_ENTER_FAST_MODE, //2
                            CMD_SET_OPTIONS, //3
                            CMD_LOAD_REG_LOW, //4
                            CMD_LOAD_REG_HIGH, //5
                            CMD_LATCH_STATE, //6
                            CMD_RESET_WAIT_CYCLES, //7
                            CMD_LONG_WAIT, //8
                            CMD_SET_STROBE_OPTIONS, //9
                            CMD_SET_INPUT_BUF_MEM, //10
                            CMD_WAIT_FOR_TRIGGER, //11
                            CMD_SET_LOOP_COUNT, //12
                            CMD_CONDITIONAL_JUMP_FORWARD, //13
                            CMD_CONDITIONAL_JUMP_BACKWARD, //14
                            CMD_I2C_OUT, //15
                            CMD_SPI_OUT_IN, //16
                            CMD_INPUT_REPEATED_OUT_IN, //17
                            CMD_SET_PERIODIC_TRIGGER_PERIOD, //18
                            CMD_SET_PERIODIC_TRIGGER_ALLOWED_WAIT_TIME, //19
                            CMD_WAIT_FOR_PERIODIC_TRIGGER, //20
                            CMD_WAIT_FOR_WAIT_CYCLE_NR, //21
                            CMD_DIG_IN, //22
                            CMD_TRIGGER_SECONDARY_PL_PS_INTERRUPT, //23
                            CMD_ANALOG_IN_OUT, //24
                            CMD_PL_TO_PS_COMMAND, //25
                            CMD_LOAD_COMMAND_BUFFER, //26
                            CMD_SAVE_CYCLE_COUNT_SINCE_STARTUP_IN_INPUT_BUF_MEM //27
                             } type_command; 
    
reg [48:0] wait_time;
reg [48:0] waited;
reg start_high = 0;
reg fast_mode = 0;
reg fast_mode_step = 0;

wire [4:0] current_command = command[4:0]; 

always @(posedge clock)
begin
   if ((latch_current_state) || (current_command == CMD_LATCH_STATE)) begin
        address_latched <= address;
        address_extension_latched <= address_extension; 
        wait_cycles_latched <= wait_cycles; 
   end else begin
    
    end
end

always @(posedge clock, posedge synchronous_reset)
begin
  if (synchronous_reset) begin
     wait_cycles <= 0;
  end else begin
      case (current_command)
        CMD_RESET_WAIT_CYCLES : begin
            wait_cycles <= 0;
        end
       default: wait_cycles <= wait_cycles +1;
    endcase
  end
end

/*
//create a reset signal that's synchronous with the clock
reg [2:0] reset_counter = 0;
always @(posedge clock)
begin
  if (reset) begin
     synchronous_reset <= 1;
     reset_counter <= 3;
  end 
  if (reset_counter > 0) reset_counter <= reset_counter -1;
  if (reset_counter == 0) synchronous_reset <= 0;
end

//create a reset signal that's synchronous with the clock
reg [2:0] reset_secondary_PS_PL_interrupt_counter = 0;
always @(posedge clock)
begin
  if (reset_secondary_PS_PL_interrupt) begin
     synchronous_reset_secondary_PS_PL_interrupt <= 1;
     reset_secondary_PS_PL_interrupt_counter <= 3;
  end 
  if (reset_secondary_PS_PL_interrupt_counter > 0) reset_secondary_PS_PL_interrupt_counter <= reset_secondary_PS_PL_interrupt_counter -1;
  if (reset_secondary_PS_PL_interrupt_counter == 0) synchronous_reset_secondary_PS_PL_interrupt <= 0;
end

//create a reset signal that's synchronous with the clock
reg [2:0] reset_input_mem_PS_PL_interrupt_counter = 0;
always @(posedge clock)
begin
  if (reset_input_mem_PS_PL_interrupt) begin
     synchronous_reset_input_mem_PS_PL_interrupt <= 1;
     reset_input_mem_PS_PL_interrupt_counter <= 3;
  end 
  if (reset_input_mem_PS_PL_interrupt_counter > 0) reset_input_mem_PS_PL_interrupt_counter <= reset_input_mem_PS_PL_interrupt_counter -1;
  if (reset_input_mem_PS_PL_interrupt_counter == 0) synchronous_reset_input_mem_PS_PL_interrupt <= 0;
end
*/


always @(posedge clock, posedge reset)
begin
  if (reset) begin
     synchronous_reset <= 1;
  end else begin
      synchronous_reset <= 0;
  end
end

always @(posedge clock, posedge reset_secondary_PS_PL_interrupt)
begin
  if (reset_secondary_PS_PL_interrupt) begin
     synchronous_reset_secondary_PS_PL_interrupt <= 1;
  end else begin
      synchronous_reset_secondary_PS_PL_interrupt <= 0;
  end
end

always @(posedge clock, posedge reset_input_mem_PS_PL_interrupt)
begin
  if (reset_input_mem_PS_PL_interrupt) begin
     synchronous_reset_input_mem_PS_PL_interrupt <= 1;
  end else begin
      synchronous_reset_input_mem_PS_PL_interrupt <= 0;
  end
end




always @(posedge clock)
begin
    
    if (int_clear && (!synchronous_reset)) begin //2024 08 07 strange: was "if (int_clear && (!int_clear_happened)) begin"
        int_clear_happened <= 1;
    end 
    if (synchronous_reset_secondary_PS_PL_interrupt) begin
        secondary_PS_PL_interrupt <= 0;
    end 
    if (synchronous_reset_input_mem_PS_PL_interrupt && (!synchronous_reset)) begin //2024 08 07 strange, was "if (synchronous_reset_input_mem_PS_PL_interrupt && (!reset_input_mem_PS_PL_interrupt_happened)) begin"
        reset_input_mem_PS_PL_interrupt_happened <= 1;    
    end 
    
    cycle_count_since_startup <= cycle_count_since_startup + 1;
    
    //if (current_command != CMD_SET_PERIODIC_TRIGGER_PERIOD) begin
    if (periodic_trigger_count_internal < periodic_trigger_period) begin
        periodic_trigger_count_internal <= periodic_trigger_count_internal +1;
        periodic_trigger_count <= periodic_trigger_count_internal; //pipelining needed to meet timing constraints
    end else begin   
        periodic_trigger_count_internal <= 0;
        periodic_trigger_count <= 0;
        PERIODIC_TRIGGER_state <= PERIODIC_TRIGGER_START;
    end
    //end else periodic_trigger_count_internal <= 0;
    if (current_command != CMD_WAIT_FOR_PERIODIC_TRIGGER) begin
        waiting_for_periodic_trigger <= 0;
        periodic_trigger_wait_cycles <= 0;            
    end else begin //2024 08 07 "else" was missing here
        waiting_for_periodic_trigger <= 1;
        periodic_trigger_wait_cycles <= periodic_trigger_wait_cycles + 1;
    end
    
    case (PERIODIC_TRIGGER_state)
        PERIODIC_TRIGGER_IDLE: begin
            periodic_trigger_signal <= 0;  
        end
        PERIODIC_TRIGGER_START: begin
            periodic_trigger_signal <= 1;  
            PERIODIC_TRIGGER_state <= PERIODIC_TRIGGER_WAIT1; 
        end
        PERIODIC_TRIGGER_WAIT1: begin    
            PERIODIC_TRIGGER_state <= PERIODIC_TRIGGER_WAIT2;
        end
        PERIODIC_TRIGGER_WAIT2: begin    
            PERIODIC_TRIGGER_state <= PERIODIC_TRIGGER_WAIT3;
        end
        PERIODIC_TRIGGER_WAIT3: begin    
            PERIODIC_TRIGGER_state <= PERIODIC_TRIGGER_WAIT4;
        end
        PERIODIC_TRIGGER_WAIT4: begin    
            PERIODIC_TRIGGER_state <= PERIODIC_TRIGGER_WAIT5;
        end
        PERIODIC_TRIGGER_WAIT5: begin    
            PERIODIC_TRIGGER_state <= PERIODIC_TRIGGER_STOP;
        end
        PERIODIC_TRIGGER_STOP: begin    
            PERIODIC_TRIGGER_state <= PERIODIC_TRIGGER_IDLE;
        end
        default: PERIODIC_TRIGGER_state <= PERIODIC_TRIGGER_IDLE;
    endcase
   
    
    if (synchronous_reset) begin
        start_high <= 0;
        address <= 0;
        wait_time <= 1;
        waited <= 0;
        running <= 0;
        strobe_generator_state <= STROBE_GEN_IDLE;
        int_out <= 0;
        int_clear_happened <= 0;
        input_mem_PS_PL_interrupt <= 0;
        secondary_PS_PL_interrupt <= 0;
        reset_input_mem_PS_PL_interrupt_happened <= 0;
        address_extension <= 0;
        input_buf_mem_address <= 0;
        input_buf_mem_data <= 0;
        input_buf_data_high_32_bit <= 0;
        options <= 0;
        strobe_choice <= 0; 
        strobe_delay <= 0; 
        strobe_low_length <= 0;
        strobe_high_length <= 0; 
        clock_cycles_this_run <= 0;
        loop_count <= 0;
        fast_mode <= 0;
        fast_mode_step <= 0;
        I2C_delay <= 0;
        I2C_bit <= 0;
        strobe_generator_state <= STROBE_GEN_IDLE;
        I2C_state <= I2C_IDLE;
        error_detected <= 0;
        INPUT_REPEAT_state <= INPUT_REPEAT_IDLE;                      
        SPI_state <= SPI_IDLE;
        DIG_IN_state <= DIG_IN_IDLE;
        register <= 0;
        trigger_out <= 0;
        adc_conversion_start <= 0;
        ANA_IN_state <= ANA_IN_IDLE;
        adc_write_enable <= 0;
        PL_to_PS_command <= 0;
        SPI_chip_select <= 'hF;
    end else begin
        if (start) begin  //we really start when "start" signal goes low again
            start_high <= 1;
            running <= 0;
            clock_cycles_this_run <= 0;
        end 
        if (start_high) begin  //can only happen if start has been 1 and now is again 0
            start_high <= 0;
            address <= 0;
            wait_time <= 1;
            waited <= 0;
            running <= 1;  //in next clock cycle we really start
            trigger_out <= 1;
        end 
        if (running) begin
            clock_cycles_this_run <= clock_cycles_this_run + 1;
          
            if (waited < wait_time) begin
                waited <= waited +1;
            end else begin       
              
                if (address[14:0] == 1) begin  //load next data block by DMA
                    if (!int_clear_happened) int_out <= 1;
                    else int_out <= 0;
                end else if (address[14:0] > 1) begin  //load next data block by DMA
                    if (int_clear_happened) begin 
                        int_out <= 0;
                        int_clear_happened <= 0;
                    end 
                end 
            
                if (address == 'hFFFF) begin
                    address_extension <= address_extension + 1;
                end 
                
                if (input_buf_mem_address[11:0] == 1) begin
                    if (!reset_input_mem_PS_PL_interrupt_happened) input_mem_PS_PL_interrupt <= 1;
                    else input_mem_PS_PL_interrupt <= 0;    
                end else if (input_buf_mem_address[11:0] > 1 ) begin
                    if (reset_input_mem_PS_PL_interrupt_happened) begin
                        input_mem_PS_PL_interrupt <= 0;    
                        reset_input_mem_PS_PL_interrupt_happened <= 0;
                    end 
                end 
                
                
                waited <= 0;
                
                
                //Fast Mode start
                if (fast_mode == 1) begin   
                    // in fast mode there are two consecutive bus commands stored in one 64bit command at the expense of only 24 bit long data and 8 bit long wait times. 
                    // if the wait time is 255 then the command will not be executed and from the next command on the code will be interpreted normally again.
                    // [63:40] 24bit data_1 | [39:32] 8bit wait_1 | [31:8] 24bit data_0 | [7:0] 8bit wait_0
                    // make sure to never jump into a fast mode command using CMD_CONDITIONAL_JUMP_FORWARD or CMD_CONDITIONAL_JUMP_BACKWARD
                    if (fast_mode_step == 0) begin
                        if (command[7:0] == 255) begin
                            wait_time[47:0] <= 0;
                            fast_mode <= 0;
                            address <= address + 1;
                        end else begin
                            wait_time[7:0] <= command[7:0];
                            wait_time[47:8] <= 0;
                            bus_data[23:0] <= command[31:8];     
                            fast_mode_step <= 1;
                        end
                    end else begin
                        if (command[39:32] == 255) begin
                            wait_time[47:0] <= 0;
                            fast_mode <= 0;
                            address <= address + 1;
                        end else begin
                            wait_time[7:0] <= command[39:32];
                            wait_time[47:8] <= 0;
                            bus_data[23:0] <= command[63:40];     
                            fast_mode_step <= 0;
                            fast_mode <= command[0:0];
                            address <= address + 1;
                        end
                    end
                    if (bus_clock) bus_clock <= 0; else bus_clock <= 1;                   
                    strobe_generator_state <= DELAY_CYCLE;                  
                end else 
                
                begin
                   case (current_command)
                        CMD_STOP:begin
                            running <= 0;
                            trigger_out <= 0;
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_SET_OPTIONS:begin
                            options <= command_buffer[63:32];
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_LOAD_COMMAND_BUFFER:begin
                            command_buffer <= command[63:0];
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_STEP:begin
                            wait_time[30:0] <= command[35:5];
                            wait_time[47:31] <= 0;
                            bus_data <= command[63:36];     
                            if (bus_clock) bus_clock <= 0; else bus_clock <= 1;                   
                            strobe_generator_state <= DELAY_CYCLE;   
                            address <= address + 1; 
                        end
                        CMD_STEP_AND_ENTER_FAST_MODE: begin
                            wait_time[30:0] <= command[35:5];
                            wait_time[47:31] <= 0;
                            bus_data <= command[63:36];     
                            if (bus_clock) bus_clock <= 0; else bus_clock <= 1;                   
                            strobe_generator_state <= DELAY_CYCLE;    
                            fast_mode <= 1;
                            fast_mode_step <= 0;
                            address <= address + 1;
                        end
                        CMD_LONG_WAIT:begin
                            wait_time[47:0] <= command_buffer[52:5];  
                            address <= address + 1;  
                        end
                        CMD_LOAD_REG_LOW:begin
                            register[58:0] <= command[63:5];
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_LOAD_REG_HIGH:begin
                            register[117:59] <= command[63:5];
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_SET_STROBE_OPTIONS: begin
                            strobe_choice <= command_buffer[11:8]; // 3 bit
                            strobe_low_length <= command_buffer[23:16]; // 8 bit
                            strobe_high_length <= command_buffer[31:24]; // 8 bit
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_SET_INPUT_BUF_MEM: begin
                            //output reg [11:0] input_buf_mem_address = 0;
                            //output reg [31:0] input_buf_mem_data = 0;
                            if (command_buffer[7:7] == 1) input_buf_mem_address <= command_buffer[20:8];
                            //else input_buf_mem_address <= input_buf_mem_address + 1;
                            input_buf_mem_data <= command_buffer[63:32];
                            INPUT_MEM_state <= INPUT_MEM_WRITE;
                            wait_time <= 1;
                            address <= address + 1;             
                        end 
                        CMD_SAVE_CYCLE_COUNT_SINCE_STARTUP_IN_INPUT_BUF_MEM: begin
                            //output reg [11:0] input_buf_mem_address = 0;
                            //output reg [31:0] input_buf_mem_data = 0;
                            //if (command_buffer[7:7] == 1) input_buf_mem_address <= command_buffer[20:8];
                            //else input_buf_mem_address <= input_buf_mem_address + 1;
                            input_buf_mem_data <= cycle_count_since_startup[31:0];
                            input_buf_data_high_32_bit[23:0] <= cycle_count_since_startup[55:32]; //reg [55:0] cycle_count_since_startup = 0;
                            input_buf_data_high_32_bit[31:24] <= 0;
                            INPUT_MEM_state <= INPUT_MEM_WRITE_64BIT;
                            wait_time <= 1;
                            address <= address + 1;             
                        end 
                        
                        
                        CMD_WAIT_FOR_TRIGGER: begin
                            if ((trigger_0 && (command_buffer[8:8] == 1)) || (trigger_1 && (command_buffer[9:9] == 1)) || (trigger_PS && (command_buffer[10:10] == 1))) address <= address + 1;
                            wait_time <= 1;
                        end
                        
                        CMD_SET_LOOP_COUNT: begin
                            loop_count <= command_buffer[63:32];
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_CONDITIONAL_JUMP_FORWARD: begin  //here we assume that the program assembling the sequence has made sure that the jump is within the current BRAM half
                            if ((condition_0 && (command_buffer[8:8] == 1)) || (condition_1 && (command_buffer[9:9] == 1)) || (condition_PS && (command_buffer[10:10] == 1)) || (command_buffer[11:11] == 1)) 
                                address <= address + command_buffer[15:8];
                            else address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_CONDITIONAL_JUMP_BACKWARD: begin  //here we assume that the program assembling the sequence has made sure that the jump is within the current BRAM half
                            if (((condition_0 && (command_buffer[8:8] == 1)) || (condition_1 && (command_buffer[9:9] == 1)) || (condition_PS && (command_buffer[10:10] == 1)) || 
                                 (command_buffer[11:11] == 1) || ((command_buffer[12:12] == 1) && (loop_count > 0)))) 
                                address <= address - command_buffer[15:8];
                            else address <= address + 1;
                            loop_count <= loop_count - 1;
                            wait_time <= 1;
                        end
                        CMD_I2C_OUT : begin
                            I2C_length <= command_buffer[14:8];
                            I2C_SELECT_NEXT <= command_buffer[17:16];
                            I2C_data <= register;  //Use CMD_LOAD_REG_LOW and CMD_LOAD_REG_HIGH before CMD_I2C_OUT to copy 117-bit I2C data to register                
                            I2C_state <= I2C_START;
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        
                        
                        CMD_SPI_OUT_IN : begin
                            SPI_OUT_length <= command_buffer[14:8];
                            SPI_IN_length <= command_buffer[20:16];
                            SPI_SEL_next <= command_buffer[33:32];
                            SPI_chip_select_next <= command_buffer[37:34];
                            SPI_data <= register;  //Use CMD_LOAD_REG_LOW and CMD_LOAD_REG_HIGH before CMD_SPI_OUT_IN to copy 117-bit I2C data to register    
                            //input_buf_mem_data[15:0] <= 0;                                      
                            INPUT_REPEAT_state <= INPUT_REPEAT_IDLE;
                            if (command_buffer[40:40] == 0) SPI_state <= SPI_START;    
                            address <= address + 1;      
                            wait_time <= 1;                                               
                        end       
                        CMD_INPUT_REPEATED_OUT_IN : begin   //This is a two cycle operation. The last state has to be LOAD_EXTENDED_DATA, in order to avoid writing the flg given here to the channels. The opcode I2C_OUT is encountered in that state, and argument stored. Here we use this stored argument.
                            INPUT_REPEAT_repeats <= command_buffer[27:8]; 
                            INPUT_REPEAT_wait <= command_buffer[55:32]; //Use LOAD_EXTENDED_DATA before INPUT_REPEATED_OUT to copy 64-bit channel content to extended_data                     
                            INPUT_REPEAT_trigger_secondary_interrupt_when_finished <= command_buffer[56:56];
                            INPUT_REPEAT_state <= INPUT_REPEAT_START;
                            INPUT_REPEAT_command <= command_buffer[59:57];
                            if (bus_clock) bus_clock <= 0; else bus_clock <= 1;                                          
                            strobe_generator_state <= DELAY_CYCLE;    
                            address <= address + 1;   
                            wait_time <= 1;               
                        end           
                        
                        
                        CMD_WAIT_FOR_WAIT_CYCLE_NR: begin //execute next command only when wait_cycles has grown to specified value
                            if (wait_cycles == command_buffer[55:8]) address <= address + 1;
                            wait_time <= 1;
                        end
                        
                        
                        CMD_SET_PERIODIC_TRIGGER_PERIOD: begin  
                            periodic_trigger_period <= command_buffer[55:8];
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_SET_PERIODIC_TRIGGER_ALLOWED_WAIT_TIME: begin 
                            periodic_trigger_allowed_wait_cycles <= command_buffer[55:8];
                            address <= address + 1;
                            wait_time <= 1;
                        end 
                        CMD_WAIT_FOR_PERIODIC_TRIGGER: begin 
                            if (periodic_trigger_signal == 1) begin //note: if this if section is commented out the program indeed stalls
                                if (periodic_trigger_wait_cycles < periodic_trigger_allowed_wait_cycles) warning_missed_periodic_trigger <= 0;
                                else warning_missed_periodic_trigger <= 1;  
                                address <= address + 1;
                            end
                            wait_time <= 1;
                        end 
                        
                        
                        CMD_DIG_IN: begin
                            input_buf_mem_data[7:0] <= core_dig_in;
                            input_buf_mem_data[31:8] <= command_buffer[31:8];
                            //input_buf_mem_address <= input_buf_mem_address + 1;
                            INPUT_MEM_state <= INPUT_MEM_WRITE;
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_TRIGGER_SECONDARY_PL_PS_INTERRUPT: begin
                            secondary_PS_PL_interrupt <= 1;
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        CMD_ANALOG_IN_OUT: begin
                            adc_register_address <= command_buffer[14:8];  //to read standard analog in, this should be 3, see Xilinx user guide UG480
                            adc_write_enable <= command_buffer[15:15];
                            adc_programming_out <= command_buffer[31:16];   
                            wait_time[29:0] <= command_buffer[63:34];
                            wait_time[47:30] <= 0;                         
                            INPUT_REPEAT_state <= INPUT_REPEAT_IDLE;
                            if (command_buffer[32:32] == 0) begin  //if command[32:32] is high, the actual reading will be started trhough CMD_REPEAT
                                if (command_buffer[33:33] == 0) ANA_IN_state <= ANA_IN_START; //conversion and register read
                                else ANA_IN_state <= ANA_IN_TRIGGER_READ_WRITE; //only register read or write
                            end
                            address <= address + 1;  
                        end
                        
                        CMD_PL_TO_PS_COMMAND: begin
                            PL_to_PS_command <= command_buffer[23:8]; 
                            address <= address + 1;
                            wait_time <= 1;
                        end
                        default: begin
                            address <= address + 1;
                            wait_time <= 1;
                        end
                    endcase
                end
            end    
                   
                   
            case (strobe_generator_state)
                STROBE_GEN_IDLE: begin
                        bus_strobe <= 0;
                        strobe_delay <= 0;
                    end
                DELAY_CYCLE: begin
                    if (strobe_delay < strobe_low_length) begin                
                        strobe_delay <= strobe_delay + 1;
                        bus_strobe <= 0;
                    end else begin
                        strobe_delay <= 0;
                        bus_strobe <= 1;                
                        strobe_generator_state <= PULSE_CYCLE;
                    end
                end
                PULSE_CYCLE: begin
                    if (strobe_delay < strobe_high_length) begin                
                        strobe_delay <= strobe_delay + 1;
                        bus_strobe <= 1;
                    end else begin
                        strobe_delay <= 0;
                        bus_strobe <= 0;
                        strobe_generator_state <= STROBE_GEN_IDLE;
                    end
                end
                default: begin
                   strobe_generator_state <= STROBE_GEN_IDLE;
                   strobe_delay <= 0;
                   bus_strobe <= 0;
                end
            endcase
            
            

            //I2C transmission; would be nice to have this in second "always" block, but then the "two values on one net" error occurs
             //here we assume a 100MHz clock, i.e. 10ns per cycle
             case (I2C_state)
                I2C_IDLE: begin
                        I2C_SCL <= 1;
                        I2C_SDA <= 1;
                        I2C_delay <= 0;
                        I2C_SELECT_0 <= 0;
                        I2C_SELECT_1 <= 0;
                    end
                I2C_START: begin
                    if (I2C_delay<60) begin  //pull SDA low and wait 600ns
                        I2C_SELECT_0 <= I2C_SELECT_NEXT[0:0];
                        I2C_SELECT_1 <= I2C_SELECT_NEXT[1:1];                        
                        I2C_SDA <= 0;
                        I2C_bit <= 0;
                        I2C_delay <= I2C_delay + 1;
                    end else begin
                        I2C_delay <= 0;
                        I2C_state <= I2C_START_SCL_LOW;
                    end
                end
                I2C_START_SCL_LOW: begin
                    if (I2C_delay<130) begin  //pull SCL low and wait 1300ns
                        I2C_SCL <= 0;
                        I2C_delay <= I2C_delay + 1;
                    end else begin
                        I2C_delay <= 0;
                        I2C_state <= I2C_DATA_LOAD;
                    end
                end
                I2C_DATA_LOAD: begin
                    if (I2C_delay<40) begin  //put data on SDA and wait 400ns
                        I2C_SDA <= I2C_data[I2C_bit];  //seems not to be able to address: ToDo: alternative programming with @always statement putting I2C_data[I2C_bit] onto specific wire, which will be used here
                        I2C_delay <= I2C_delay + 1;
                    end else begin
                        I2C_delay <= 0;                
                        I2C_state <= I2C_CLOCK_HIGH;
                    end
                end
                I2C_CLOCK_HIGH: begin
                    if (I2C_delay<60) begin  //put SCL high and wait 600ns
                        I2C_SCL <= 1;
                        I2C_delay <= I2C_delay + 1;
                    end else begin
                        I2C_delay <= 0;         
                        I2C_bit <= I2C_bit +1;       
                        I2C_state <= I2C_CLOCK_LOW;
                    end
                end
                I2C_CLOCK_LOW: begin
                    if (I2C_delay<20) begin  //put SCL low and wait 200ns
                        I2C_SCL <= 0;
                        I2C_delay <= I2C_delay + 1;
                    end else begin
                        I2C_delay <= 0;           
                        if (I2C_bit < I2C_length) begin
                            I2C_state <= I2C_START_SCL_LOW;
                        end else begin
                            I2C_state <= I2C_STOP;
                        end 
                    end
                end
                I2C_STOP: begin
                    if (I2C_delay<130) begin  //put SCL low and wait 1300ns
                        I2C_SCL <= 0;
                        I2C_delay <= I2C_delay + 1;
                    end else begin
                        I2C_delay <= 0;              
                        I2C_state <= I2C_STOP_SCL_HIGH;
                    end
                end
                I2C_STOP_SCL_HIGH: begin
                    if (I2C_delay<60) begin  //put SCL high and wait 600ns
                        I2C_SCL <= 1;
                        I2C_delay <= I2C_delay + 1;
                    end else begin
                        I2C_delay <= 0;              
                        I2C_state <= I2C_IDLE;
                    end
                end
                default: I2C_state <= I2C_IDLE;
            endcase
            
            
            
            
             //here we assume a 100MHz clock, i.e. 10ns per cycle
             //reminder: SPI IO: 
                //input SPI_IN;
                //output reg SPI_OUT = 0;
                //output reg SPI_SCK = 0;
                //output reg [1:0] SPI_SEL = 2'b11;              
             case (SPI_state)
                SPI_IDLE: begin
                        SPI_SCK <= 1;
                        SPI_OUT <= 1;
                        SPI_delay <= 0;
                        SPI_OUT_bit_nr <= 0;
                        SPI_IN_bit_nr <= SPI_IN_length;//SPI analog input sends 13 bits, starting with 0 and then with highest significant bit first.
                        SPI_SELECT_0 <= 0;
                        SPI_SELECT_1 <= 0;    
                        SPI_chip_select <= 'hF;
                        input_buf_mem_data_SPI = 0;                     
                    end
                SPI_START: begin
                    if (SPI_delay<4) begin //50ns from CS low to start of normal clock cycle (i.e. 100ns till first clock rise)
                        SPI_SELECT_0 <= SPI_SEL_next[0:0];
                        SPI_SELECT_1 <= SPI_SEL_next[1:1];
                        SPI_chip_select <= SPI_chip_select_next;
                        SPI_SCK <= 0;
                        SPI_OUT <= SPI_data[SPI_OUT_bit_nr];                        
                        SPI_delay <= SPI_delay + 1;
                    end else begin
                        SPI_delay <= 0;
                        SPI_state <= SPI_SCL_LOW_DATA_OUT;
                    end
                end
                SPI_SCL_LOW_DATA_OUT: begin
                    if (SPI_delay<4) begin  //pull SCL low and wait 50ns
                        SPI_SCK <= 0;
                        SPI_OUT <= SPI_data[SPI_OUT_bit_nr];
                        SPI_delay <= SPI_delay + 1;
                    end else begin
                        SPI_delay <= 0;
                        SPI_OUT_bit_nr <= SPI_OUT_bit_nr +1;
                        SPI_state <= SPI_SCL_HIGH_DATA_OUT;
                    end
                end
                SPI_SCL_HIGH_DATA_OUT: begin
                    if (SPI_delay<4) begin  //rise clock and wait 50ns; data is read by SDI device on this clock edge
                        SPI_SCK <= 1;
                        SPI_delay <= SPI_delay + 1;                        
                    end else begin
                        SPI_delay <= 0;                
                        if (SPI_OUT_bit_nr < SPI_OUT_length)
                            SPI_state <= SPI_SCL_LOW_DATA_OUT;
                        else 
                            SPI_state <= SPI_SCL_LOW_DATA_IN;
                    end
                end
                SPI_SCL_LOW_DATA_IN: begin                       
                    SPI_IN_bit_nr <= SPI_IN_bit_nr - 1;                                
                    SPI_state <= SPI_SCL_LOW_DATA_IN_WAIT;                                            
                end
                SPI_SCL_LOW_DATA_IN_WAIT: begin
                    if (SPI_delay<23) begin  //put SCL low and wait 250ns; data is placed on input at this edge, except for first time
                        if (SPI_IN_length == 0) SPI_state <= SPI_IDLE;
                        SPI_SCK <= 0;
                        SPI_delay <= SPI_delay + 1;                        
                    end else begin
                        SPI_delay <= 0;                               
                        SPI_SCK <= 1;
                        SPI_state <= SPI_SCL_HIGH_DATA_IN_WAIT;
                        input_buf_mem_data_SPI[SPI_IN_bit_nr] <= (SPI_IN_0 & SPI_SELECT_0) | (SPI_IN_1 & SPI_SELECT_1);
                        
                    end
                end
                SPI_SCL_HIGH_DATA_IN_WAIT: begin
                    if (SPI_delay<24) begin  //put SCL high, read data and wait 250ns
                        SPI_delay <= SPI_delay + 1;                        
                    end else begin
                        SPI_delay <= 0;         
                        if (SPI_IN_bit_nr == 0) begin
                            SPI_state <= SPI_WRITE_TO_INPUT_MEMORY;
                        end else begin
                            SPI_state <= SPI_SCL_LOW_DATA_IN;
                        end 
                    end
                end
                SPI_WRITE_TO_INPUT_MEMORY: begin
                    //the input_buf_mem_data_SPI register is used to separate circuitry needed for individial bit setting in SPI from circutry needed to write to input_mem
                    //input_buf_mem_data is accessed by ana_in, dig_in, SPI_in, ... The hope is to not overcomplicate things by adding bit manipulation circuitry to that. 
                    //if circuit would become too complicated we will get issues with timing.
                    input_buf_mem_data[15:0] <= input_buf_mem_data_SPI[15:0];
                    INPUT_MEM_state <= INPUT_MEM_WRITE;
                    SPI_state <= SPI_STOP;
                end
                SPI_STOP: begin
                    //input_buf_mem_address <= input_buf_mem_address + 1;
                    SPI_state <= SPI_IDLE;                    
                end
                default: SPI_state <= SPI_IDLE;
            endcase
            
            case (INPUT_MEM_state)
                INPUT_MEM_IDLE: begin
                end
                
                INPUT_MEM_WRITE_64BIT: begin
                    input_buf_mem_write <= 1;
                    INPUT_MEM_state <= INPUT_MEM_WRITE_2_64BIT;
                end
                INPUT_MEM_WRITE_2_64BIT: begin
                    INPUT_MEM_state <= INPUT_MEM_WRITE_3_64BIT;
                end
                INPUT_MEM_WRITE_3_64BIT: begin
                    input_buf_mem_write <= 0;
                    input_buf_mem_address <= input_buf_mem_address + 1;
                    INPUT_MEM_state <= INPUT_MEM_WRITE_4_64BIT;
                end
                INPUT_MEM_WRITE_4_64BIT: begin
                    input_buf_mem_data <= input_buf_data_high_32_bit;
                    INPUT_MEM_state <= INPUT_MEM_WRITE;
                end

                INPUT_MEM_WRITE: begin
                    input_buf_mem_write <= 1;
                    INPUT_MEM_state <= INPUT_MEM_WRITE_2;
                end
                INPUT_MEM_WRITE_2: begin
                    INPUT_MEM_state <= INPUT_MEM_STOP;
                end
                INPUT_MEM_STOP: begin
                    input_buf_mem_write <= 0;
                    input_buf_mem_address <= input_buf_mem_address + 1;
                    INPUT_MEM_state <= INPUT_MEM_IDLE;
                end
                default: begin
                    input_buf_mem_write <= 0;
                    INPUT_MEM_state <= INPUT_MEM_IDLE;
                end
            endcase
            
            //storing adc result in core registers, just in cae adc outputs go to zero when adc_ready goes to zero
            if (adc_ready) begin
                ana_in_data <= adc_result_in;
                ana_in_channel <= adc_channel;
            end 
            
            case (ANA_IN_state)
                ANA_IN_IDLE: begin
                    ANA_IN_delay <= 0;
                    adc_conversion_start <= 0;
                end
                ANA_IN_START: begin
                    if (ANA_IN_delay<110) begin  //need to wait 22 ADCCLK = 88 DCLK  + 16 DCLK = 104 DLCK cycles. Do a bit more for safety
                        adc_conversion_start <= 1;                        
                        ANA_IN_delay <= ANA_IN_delay + 1;
                    end else begin
                        ANA_IN_delay <= 0;
                        adc_conversion_start <= 0;
                        ANA_IN_state <= ANA_IN_TRIGGER_READ_WRITE;
                    end
                end
                ANA_IN_TRIGGER_READ_WRITE: begin
                    if (ANA_IN_delay<2) begin
                        ana_in_data_expected <= !adc_write_enable;
                        adc_enable <= 1;
                        ANA_IN_delay <= ANA_IN_delay + 1;
                     end else begin
                        adc_enable <= 0;
                        ANA_IN_delay <= 0;
                        if (ana_in_data_expected) ANA_IN_state <= ANA_IN_INCREASE_INPUT_MEM_ADDRESS;
                        else ANA_IN_state <= ANA_IN_IDLE;
                     end
                end
                ANA_IN_INCREASE_INPUT_MEM_ADDRESS: begin
                    //it nominally takes 5 to 6 DCLK cycles to present result. 
                    //DRDY = adc_ready has a high transition when data ready, which we use to read in data into ana_in_data and ana_in_channel (see "always" block above). 
                    //After a few safety cycles we increase input buffer address. 
                    //The address has to be increased here to avoid multiple driver nets for address.
                    if (ANA_IN_delay<10) begin   
                        ANA_IN_delay <= ANA_IN_delay + 1;
                     end else begin
                        input_buf_mem_data[15:0] <= ana_in_data;
                        input_buf_mem_data[20:16] <= ana_in_channel;
                        input_buf_mem_data[28:21] <= core_dig_in;
                        input_buf_mem_data[30:29] <= INPUT_REPEAT_nr[1:0];
                        input_buf_mem_data[31:31] <= 1'b1; 
                        //input_buf_mem_address <= input_buf_mem_address + 1;
                        INPUT_MEM_state <= INPUT_MEM_WRITE;
                        ana_in_data_expected <= 0;
                        ANA_IN_state <= ANA_IN_IDLE;
                     end
                end
                                
                default: ANA_IN_state <= ANA_IN_IDLE;
            endcase
            
            case (DIG_IN_state)
                DIG_IN_IDLE: begin
                                              
                end
                DIG_IN_START: begin
                    input_buf_mem_data[7:0] <= core_dig_in;
                    input_buf_mem_data[28:8] <= INPUT_REPEAT_nr;
                    input_buf_mem_data[31:29] <= 3'b010; 
                    //input_buf_mem_address <= input_buf_mem_address + 1;
                    INPUT_MEM_state <= INPUT_MEM_WRITE;
                    DIG_IN_state <= DIG_IN_IDLE;                 
                end
                default: DIG_IN_state <= DIG_IN_IDLE;
            endcase
            
            

        //reminder: parameters
        //reg [23:0] INPUT_REPEAT_wait = 0;
        //reg [24:0] INPUT_REPEAT_delay = 0;
        //reg [19:0] INPUT_REPEAT_repeats = 0;
        //reg [20:0] INPUT_REPEAT_nr = 0;
         case (INPUT_REPEAT_state)
                INPUT_REPEAT_IDLE: begin
                        INPUT_REPEAT_nr <= 0;    
                        INPUT_REPEAT_delay <= 0;  
                    end
                INPUT_REPEAT_START: begin
                    if (INPUT_REPEAT_command[0] == 1) SPI_state <= SPI_START;
                    if (INPUT_REPEAT_command[1] == 1) DIG_IN_state <= DIG_IN_START;
                    if (INPUT_REPEAT_command[2] == 1) ANA_IN_state <= ANA_IN_START;
                    INPUT_REPEAT_delay <= 0;
                    INPUT_REPEAT_state <= INPUT_REPEAT_WAIT;       
                    if (INPUT_REPEAT_repeats != 'hFFFFF) INPUT_REPEAT_nr <= INPUT_REPEAT_nr + 1;       //INPUT_REPEAT_repeats == 'hFFFFF leads to repeats till INPUT_REPEAT_repeats is set to zero
                end
                INPUT_REPEAT_WAIT: begin    
                    if (INPUT_REPEAT_delay < INPUT_REPEAT_wait) begin                                                
                        INPUT_REPEAT_delay <= INPUT_REPEAT_delay + 1;
                    end else begin
                        SPI_delay <= 0;                         
                        if (INPUT_REPEAT_nr < INPUT_REPEAT_repeats)
                            INPUT_REPEAT_state <= INPUT_REPEAT_START;
                        else begin
                            INPUT_REPEAT_state <= INPUT_REPEAT_IDLE;
                            if (INPUT_REPEAT_trigger_secondary_interrupt_when_finished) 
                                secondary_PS_PL_interrupt <= 1;  
                        end
                    end
                end
                default: INPUT_REPEAT_state <= INPUT_REPEAT_IDLE;
            endcase
             
        end
    end
end


    
endmodule
