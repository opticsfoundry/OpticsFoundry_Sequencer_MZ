/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */


#include "xparameters.h"
#include "stdio.h"
#include "xil_testmem.h"
#include "xil_exception.h"
#include "xil_types.h"
#include "xil_cache.h"
#include "xgpio.h"

#include "xuartps.h"	// if PS uart is used
#include "xscutimer.h"  // if PS Timer is used
#include "xdmaps.h"		// if PS DMA is used
#include "xscugic.h" 	// if PS GIC is used
#include "xil_printf.h"

//#include "xtmrctr.h"
//#include "math.h"
//#include "xplatform_info.h"
#include "xgpiops.h"
//#include "xil_io.h"
//#ifdef XPAR_INTC_0_DEVICE_ID
//#include "xintc.h"
//#include <stdio.h>
//#else
//#include "xscugic.h"
//#endif


//These BRAM parameters are currently set incorrectly in SDK 2014.4 xparameters.h
//This is a known bug that is scheduled to be fixed in 2015.1
//See http://forums.xilinx.com/t5/Zynq-All-Programmable-SoC/Bram-parameters-in-Xparameters-h/m-p/555182/highlight/true#M5042
#undef XPAR_AXI_BRAM_CTRL_0_BASEADDR
#undef XPAR_AXI_BRAM_CTRL_0_HIGHADDR
#define XPAR_AXI_BRAM_CTRL_0_BASEADDR 0x40000000
#define XPAR_AXI_BRAM_CTRL_0_HIGHADDR 0x40001FFF

#define BRAM_MEMORY XPAR_AXI_BRAM_CTRL_0_BASEADDR

#define RESET_LOOP_COUNT	10	// Number of times to check reset is done
#define LENGTH 8192 // source and destination buffers lengths in number of words
#define DDR_MEMORY XPAR_PS7_DDR_0_S_AXI_BASEADDR+0x00020000 // pass all code and data sections
#define TIMER_DEVICE_ID	XPAR_SCUTIMER_DEVICE_ID
#define TIMER_LOAD_VALUE 0xFFFFFFFF
#define DMA0_ID XPAR_XDMAPS_1_DEVICE_ID
#define INTC_DEVICE_INT_ID XPAR_SCUGIC_SINGLE_DEVICE_ID

volatile static int Done = 0;	/* Dma transfer is done */
volatile static int Error = 0;	/* Dma Bus Error occurs */

XUartPs Uart_PS;		/* Instance of the UART Device */
XScuTimer Timer;		/* Cortex A9 SCU Private Timer Instance */
XDmaPs Dma;				/* PS DMA */
XScuGic Gic;			/* PS GIC */


/*

//Interrupt demo
//http://www.globaltek.kr/zynq-interrupt-example-tutorial/?ckattempt=1

XScuGic InterruptController;
static XScuGic_Config *GicConfig;

void ExtIrq_Handler(void *InstancePtr)
{
  xil_printf("ExtIrq_Handler\r\n");
}

int SetUpInterruptSystem(XScuGic *XScuGicInstancePtr)
{
  Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler) XScuGic_InterruptHandler, XScuGicInstancePtr);
  Xil_ExceptionEnable();
  return XST_SUCCESS;
}

int interrupt_init()
{
  int Status;

  GicConfig = XScuGic_LookupConfig(XPAR_PS7_SCUGIC_0_DEVICE_ID);
  if (NULL == GicConfig) {
    return XST_FAILURE;
  }

  Status = XScuGic_CfgInitialize(&InterruptController, GicConfig, GicConfig->CpuBaseAddress);
  if (Status != XST_SUCCESS) {
    return XST_FAILURE;
  }

  Status = SetUpInterruptSystem(&InterruptController);
  if (Status != XST_SUCCESS) {
    return XST_FAILURE;
  }

  Status = XScuGic_Connect(&InterruptController, XPAR_FABRIC_EXT_IRQ_INTR, (Xil_ExceptionHandler)ExtIrq_Handler, (void *)NULL);
  if (Status != XST_SUCCESS) {
    return XST_FAILURE;
  }

  XScuGic_Enable(&InterruptController, XPAR_FABRIC_EXT_IRQ_INTR);

  return XST_SUCCESS;
}


*/

int getNumber (){

	u8 byte;
	u8 uartBuffer[16];
	u8 validNumber;
	int digitIndex;
	int digit, number, sign;
	int c;

	while(1){
		byte = 0x00;
		digit = 0;
		digitIndex = 0;
		number = 0;
		validNumber = TRUE;

		//get bytes from uart until RETURN is entered
		while(byte != 0x0d){
			while (!XUartPs_IsReceiveData(STDIN_BASEADDRESS));
			byte = XUartPs_ReadReg(STDIN_BASEADDRESS,
								    XUARTPS_FIFO_OFFSET);
			uartBuffer[digitIndex] = byte;
			XUartPs_Send(&Uart_PS, &byte, 1);
			digitIndex++;
		}

		//calculate number from string of digits

		for(c = 0; c < (digitIndex - 1); c++){
			if(c == 0){
				//check if first byte is a "-"
				if(uartBuffer[c] == 0x2D){
					sign = -1;
					digit = 0;
				}
				//check if first byte is a digit
				else if((uartBuffer[c] >> 4) == 0x03){
					sign = 1;
					digit = (uartBuffer[c] & 0x0F);
				}
				else
					validNumber = FALSE;
			}
			else{
				//check byte is a digit
				if((uartBuffer[c] >> 4) == 0x03){
					digit = (uartBuffer[c] & 0x0F);
				}
				else
					validNumber = FALSE;
			}
			number = (number * 10) + digit;
		}
		number *= sign;
		if(validNumber == TRUE){
			print("\r\n");
			return number;
		}
		print("This is not a valid number.\n\r");
	}
}

void DmaDoneHandler(unsigned int Channel,
		    XDmaPs_Cmd *DmaCmd,
		    void *CallbackRef)
{
	/* done handler */
  	Done = 1;
}

void DmaFaultHandler(unsigned int Channel,
		     XDmaPs_Cmd *DmaCmd,
		     void *CallbackRef)
{
	/* fault handler */

	Error = 1;
}

int SetupIntrSystem(XScuGic *GicPtr, XDmaPs *DmaPtr)
{
	int Status;

	Xil_ExceptionInit();

	// Connect the interrupt controller interrupt handler to the hardware
	// interrupt handling logic in the processor.
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_IRQ_INT,
			     (Xil_ExceptionHandler)XScuGic_InterruptHandler,
			     GicPtr);

	// Connect a device driver handler that will be called when an interrupt
	// for the device occurs, the device driver handler performs the specific
	// interrupt processing for the device

	// Connect the Fault ISR
	Status = XScuGic_Connect(GicPtr,
				 XPAR_XDMAPS_0_FAULT_INTR,
				 (Xil_InterruptHandler)XDmaPs_FaultISR,
				 (void *)DmaPtr);
	if (Status != XST_SUCCESS)
		return XST_FAILURE;

	// Connect the Done ISR for channel 0 of DMA 0
	Status = XScuGic_Connect(GicPtr,
				 XPAR_XDMAPS_0_DONE_INTR_0,
				 (Xil_InterruptHandler)XDmaPs_DoneISR_0,
				 (void *)DmaPtr);

	if (Status != XST_SUCCESS)
		return XST_FAILURE;

	// Enable the interrupt for the device
	XScuGic_Enable(GicPtr, XPAR_XDMAPS_0_DONE_INTR_0);

	return XST_SUCCESS;
}

u8 menu(void)
{
	u8 byte;

	print("Enter 1 for BRAM to BRAM transfer\r\n");
	print("Enter 2 for BRAM to DDR3 transfer\r\n");
	print("Enter 3 for DDR3 to BRAM transfer\r\n");
	print("Enter 4 for DDR3 to DDR3 transfer\r\n");
	print("Enter 5 to exit\r\n");
	while (!XUartPs_IsReceiveData(STDIN_BASEADDRESS));
	byte = XUartPs_ReadReg(STDIN_BASEADDRESS,
						    XUARTPS_FIFO_OFFSET);
	return(byte);

}

u8 byte_sel(void)
{
	u8 byte;

   	print("Enter number of words you want to transfer:\r\n");
   	print("1=256; 2=512; 3=1024; 4=2048; 5=4096; 6=8192;\r\n");
 	while (!XUartPs_IsReceiveData(STDIN_BASEADDRESS));
	byte = XUartPs_ReadReg(STDIN_BASEADDRESS,
						    XUARTPS_FIFO_OFFSET);
	return(byte);
}


/*****************************************************************************/
/**
* The purpose of this function is to illustrate how to use the XGpioPs component.
* It initializes the PS GPIO and sets the direction of the Output Pin.
*
* @param	PsGpioInstancePtr is a pointer to the XGpioPs driver Instance
* @param	DeviceId is the XPAR_<GPIOPS_instance>_DEVICE_ID value from	xparameters.h
* @return	XST_SUCCESS if the Test is successful, otherwise XST_FAILURE
*
*****************************************************************************/

static XGpioPs PsGpio;
extern XGpioPs_Config XGpioPs_ConfigTable[XPAR_XGPIOPS_NUM_INSTANCES];
#define GPIO_DEVICE_ID  	XPAR_XGPIOPS_0_DEVICE_ID


#define OUTPUT_PIN		3
#define INPUT_PIN		9


int PsGpioSetup(XGpioPs* PsGpioInstancePtr, u16 DeviceId)
{
	int Status;
	XGpioPs_Config*GpioConfigPtr;
	GpioConfigPtr = XGpioPs_LookupConfig(DeviceId);
	if(GpioConfigPtr == NULL){
		xil_printf(" PS GPIO INIT FAILED 1 \n\r");
		return XST_FAILURE;
		}
	xil_printf("initialize ps gpio 0\r\n");
	Status = XGpioPs_CfgInitialize(PsGpioInstancePtr,
				GpioConfigPtr,
				GpioConfigPtr->BaseAddr);
	if(XST_SUCCESS != Status){
		xil_printf(" PS GPIO INIT FAILED 2 \n\r");
		return XST_FAILURE;
		}

	xil_printf("set direction output pin\r\n");
	XGpioPs_SetDirectionPin(PsGpioInstancePtr, OUTPUT_PIN,/*0: in 1:out*/ 1);
	XGpioPs_SetOutputEnablePin(PsGpioInstancePtr, OUTPUT_PIN,/* 1 for output enable, 0: disable */ 1);

	xil_printf("set direction input pin \r\n");
	XGpioPs_SetDirectionPin(PsGpioInstancePtr, INPUT_PIN, 0);
	XGpioPs_SetOutputEnablePin(PsGpioInstancePtr, INPUT_PIN, 0);

	return XST_SUCCESS;
}


void test_ps_gpio(void) {
	int Status;

	xil_printf("test ps gpio 0\r\n");

	Status = PsGpioSetup(&PsGpio, GPIO_DEVICE_ID);
	if(XST_SUCCESS != Status){
		xil_printf(" PS GPIO INIT FAILED \n\r");
		return XST_FAILURE;
	}

	xil_printf("PS out = 0 \r\n");
	XGpioPs_WritePin(&PsGpio,OUTPUT_PIN,0);

	for (int i = 0;i<32;i++) {
		XGpioPs_WritePin(&PsGpio,i,0);
		}

	for (int i = 0;i<32;i++) {
		if (1== XGpioPs_ReadPin(&PsGpio,i)) xil_printf("1"); else xil_printf("0");
	}
	xil_printf("\r\n");

	xil_printf("PS out = 1 \r\n");

	XGpioPs_WritePin(&PsGpio,OUTPUT_PIN,1);

	for (int i = 0;i<32;i++) {
		XGpioPs_WritePin(&PsGpio,i,1);
		}

	for (int i = 0;i<32;i++) {
		if (1== XGpioPs_ReadPin(&PsGpio,i)) xil_printf("1"); else xil_printf("0");
	}
	xil_printf("\r\n");


	if (1== XGpioPs_ReadPin(&PsGpio,INPUT_PIN))
		xil_printf("PS in Turned 1 \r\n");
	else xil_printf("PS in Turned 0 \r\n");
}

void test_axi_gpio(void) {
	XGpio_Config *cfg_ptr;
	XGpio axi_gpio_0_device, axi_gpio_1_device, axi_gpio_2_device, axi_gpio_3_device;
	u32 data;
	int Status;

	xil_printf("test axi gpio 0\r\n");

	// Initialize axi_gpio_0_device
	cfg_ptr = XGpio_LookupConfig(XPAR_AXI_GPIO_0_DEVICE_ID);
	Status = XGpio_CfgInitialize(&axi_gpio_0_device, cfg_ptr, cfg_ptr->BaseAddress);
	if (XST_SUCCESS != Status){
		print(" AXI GPIO 0 INIT FAILED \n\r");
		return XST_FAILURE;
	}
	xil_printf("test axi gpio 1\r\n");
	// Initialize axi_gpio_1_device
	cfg_ptr = XGpio_LookupConfig(XPAR_AXI_GPIO_1_DEVICE_ID);
	Status = XGpio_CfgInitialize(&axi_gpio_1_device, cfg_ptr, cfg_ptr->BaseAddress);
	if (XST_SUCCESS != Status){
		print(" AXI GPIO 1 INIT FAILED \n\r");
		return XST_FAILURE;
	}
	xil_printf("test axi gpio 2\r\n");
	// Initialize axi_gpio_2_device
	cfg_ptr = XGpio_LookupConfig(XPAR_AXI_GPIO_2_DEVICE_ID);
	Status = XGpio_CfgInitialize(&axi_gpio_2_device, cfg_ptr, cfg_ptr->BaseAddress);
	if (XST_SUCCESS != Status){
		print(" AXI GPIO 2 INIT FAILED \n\r");
		return XST_FAILURE;
	}

	xil_printf("test axi gpio 3\r\n");
	// Initialize axi_gpio_3_device
	cfg_ptr = XGpio_LookupConfig(XPAR_AXI_GPIO_3_DEVICE_ID);
	Status = XGpio_CfgInitialize(&axi_gpio_3_device, cfg_ptr, cfg_ptr->BaseAddress);
	xil_printf("GPIO_3 base address: %x\r\n", cfg_ptr->BaseAddress);

	if (XST_SUCCESS != Status){
		print(" AXI GPIO 3 INIT FAILED \n\r");
		return XST_FAILURE;
	}

	xil_printf("test axi gpio 4\r\n");
	//XGpio_SetDataDirection(&axi_gpio_3_device, /*channel 1 or 2*/ 1,/*direction mask 0:out 1: in*/ 0);

	xil_printf("test axi gpio 5\r\n");
	//XGpio_SetDataDirection(&axi_gpio_3_device, /*channel 1 or 2*/2, /*direction mask 0:out 1: in*/ 0xFFFFFFFF);


	xil_printf("test axi gpio 6\r\n");
	//XGpio_DiscreteWrite(&axi_gpio_3_device, 1, 0xDEADBEEF);

	xil_printf("test axi gpio 7\r\n");
	//data = XGpio_DiscreteRead(&axi_gpio_3_device, 2);
	xil_printf("GPIO_3 test data transfer result: %x\r\n", data);

}

int main (void) {


	test_ps_gpio();
	test_axi_gpio();

	u8 select;
	int i;
    int num;
    u8 num_in;
    int dma_improvement;

    u32 * source, * destination;
    int software_cycles, interrupt_cycles;
    int test_done = 0;

	// UART related definitions
    int Status;
	XUartPs_Config *Config;

	// PS Timer related definitions
	volatile u32 CntValue1;
	XScuTimer_Config *ConfigPtr;
	XScuTimer *TimerInstancePtr = &Timer;

	// PS DMA related definitions
	XDmaPs_Config *DmaCfg;
	XDmaPs_Cmd DmaCmd = {
		.ChanCtrl = {
			.SrcBurstSize = 4,
			.SrcBurstLen = 4,
			.SrcInc = 1,		// increment source address
			.DstBurstSize = 4,
			.DstBurstLen = 4,
			.DstInc = 1,		// increment destination address
		},
	};
	unsigned int Channel = 0;

	// PS Interrupt related definitions
	XScuGic_Config *GicConfig;

	// Initialize UART
	// Look up the configuration in the config table, then initialize it.
	Config = XUartPs_LookupConfig(XPAR_XUARTPS_0_DEVICE_ID);
	if (NULL == Config) {
		return XST_FAILURE;
	}

	Status = XUartPs_CfgInitialize(&Uart_PS, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	// Initialize timer counter
	ConfigPtr = XScuTimer_LookupConfig(TIMER_DEVICE_ID);

	Status = XScuTimer_CfgInitialize(TimerInstancePtr, ConfigPtr,
				 ConfigPtr->BaseAddr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	// Initialize GIC
	GicConfig = XScuGic_LookupConfig(INTC_DEVICE_INT_ID);
	if (NULL == GicConfig) {
		xil_printf("XScuGic_LookupConfig(%d) failed\r\n",
				INTC_DEVICE_INT_ID);
		return XST_FAILURE;
	}

	Status = XScuGic_CfgInitialize(&Gic, GicConfig,
				       GicConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		xil_printf("XScuGic_CfgInitialize failed\r\n");
		return XST_FAILURE;
	}

	// Set options for timer/counter 0
	// Load the timer counter register.
	XScuTimer_LoadTimer(TimerInstancePtr, TIMER_LOAD_VALUE);

	// Start the Scu Private Timer device.
	XScuTimer_Start(TimerInstancePtr);

    print("-- Simple DMA Design Example --\r\n");

	// Get a snapshot of the timer counter value before it's started
	CntValue1 = XScuTimer_GetCounterValue(TimerInstancePtr);

	xil_printf("Above message printing took %d clock cycles\r\n", TIMER_LOAD_VALUE-CntValue1);

	// Setup DMA Controller
	DmaCfg = XDmaPs_LookupConfig(DMA0_ID);
	if (!DmaCfg) {
		xil_printf("Lookup DMAC %d failed\r\n", DMA0_ID);
		return XST_FAILURE;
	}

	Status = XDmaPs_CfgInitialize(&Dma,DmaCfg,DmaCfg->BaseAddress);

	if (Status) {
		xil_printf("XDmaPs_CfgInitialize failed\r\n");
		return XST_FAILURE;
	}

    // Setup Interrupt system here even we don't use it for the poll-DMA mode
	// as required by the PS DMA driver
	Status = SetupIntrSystem(&Gic, &Dma);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

//	Xil_ExceptionEnableMask(XIL_EXCEPTION_IRQ);

    test_done = 0;

    while(test_done==0)
    {

   	   	num_in = byte_sel();

   	   	switch(num_in)
    			{
    				case '1' :
    					num = 256;
    					print("Sending 256 bytes\r\n");
    					break;
    				case '2' :
    					num = 512;
    					print("Sending 512 bytes\r\n");
    					break;
    				case '3' :
    					num = 1024;
    					print("Sending 1024 bytes\r\n");
    					break;
    				case '4' :
    					num = 2048;
    					print("Sending 2048 bytes\r\n");
    				    break;
    				case '5' :
    					num = 4096;
    					print("Sending 4096 bytes\r\n");
    					break;
    				case '6' :
    					num = 8192;
    					print("Sending 8192 bytes\r\n");
    					break;
    				default :
    					num = 256;
    					print("Sending 256 bytes\r\n");
    					break;
    			}
   	   	print("\r\n");
   	    select = menu();

    	switch(select)
		{
			case '1' :
				source = (u32 *)BRAM_MEMORY;
				destination = (u32 *)(BRAM_MEMORY+LENGTH);
				print("BRAM to BRAM transfer\r\n");
				break;
			case '2' :
				source = (u32 *)BRAM_MEMORY;
				destination = (u32 *)DDR_MEMORY;
				print("BRAM to DDR3 transfer\r\n");
				break;
			case '3' :
				source = (u32 *)(DDR_MEMORY+LENGTH);
				destination = (u32 *)DDR_MEMORY;
				print("DDR3 to BRAM transfer\r\n");
				break;
			case '4' :
				source = (u32 *)DDR_MEMORY;
				destination = (u32 *)(DDR_MEMORY+LENGTH);
				print("DDR3 to DDR3 transfer\r\n");
				break;
			case '5' :
				test_done = 1;
			default :
				source = (u32 *)DDR_MEMORY;
				destination = (u32 *)(DDR_MEMORY+LENGTH);
				print("DDR3 to DDR3 transfer\r\n");
				break;
		}



		if(test_done)
			break;



		// Following code is required only if Cache is enabled
		Xil_DCacheFlushRange((u32)&source, LENGTH);
		Xil_DCacheFlushRange((u32)&destination, LENGTH);

		// Initialize src memory
		for (i=0; i<num; i++)
			*(source+i) = num-i;


	// Non-DMA mode
		// reset timer
		XScuTimer_RestartTimer(TimerInstancePtr);

		// start moving data through the processor - no CDMA, no interrupt
		// gives base consumed cycles
		for (i=0; i<num; i++)
			*(destination+i) = *(source+i);

		CntValue1 = XScuTimer_GetCounterValue(TimerInstancePtr);

		xil_printf("Moving data through processor took %d clock cycles\r\n", TIMER_LOAD_VALUE-CntValue1);
		software_cycles = TIMER_LOAD_VALUE-CntValue1;

	// DMA in polling mode
//		print("Starting transfer through DMA in poll mode\r\n");
		DmaCmd.BD.SrcAddr = (u32)source;
		DmaCmd.BD.DstAddr = (u32)destination;
		DmaCmd.BD.Length = num * sizeof(int);

	// setting up for interrupt driven DMA
		// clear destination memory
		for (i=0; i<num; i++)
			*(destination+i) = 0;

		print("Setting up interrupt system\r\n");
		Status = SetupIntrSystem(&Gic, &Dma);
		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}

		Xil_ExceptionEnableMask(XIL_EXCEPTION_IRQ);

		XDmaPs_SetDoneHandler(&Dma,0,DmaDoneHandler,0);
		Status = XDmaPs_Start(&Dma, Channel, &DmaCmd, 0);	// release DMA buffer as we are done

		// reset timer
		XScuTimer_RestartTimer(TimerInstancePtr);

		while ((Done==0) & (Error==0));
		if (Error)
			print("Error occurred during DMA transfer\r\n");

		CntValue1 = XScuTimer_GetCounterValue(TimerInstancePtr);

		xil_printf("Moving data through DMA in Interrupt mode took %d clock cycles\r\n", TIMER_LOAD_VALUE-CntValue1);
		interrupt_cycles = TIMER_LOAD_VALUE-CntValue1;

		print("Transfer complete\r\n");
		// Disable the interrupt for the device
		XScuGic_Disable(&Gic, XPAR_XDMAPS_0_DONE_INTR_0);

		for (i = 0; i < num; i++) {
				if ( destination[i] != source[i]) {
					xil_printf("Data match failed at = %d, source data = %d, destination data = %d\n\r",i,source[i],destination[i]);
					print("-- Exiting main() --");
					return XST_FAILURE;
				}
			}
		print("Transfered data verified\r\n");
		dma_improvement = software_cycles/interrupt_cycles;
		xil_printf("Improvement using Interrupt DMA = %2d", dma_improvement);
		xil_printf("x improvement \r\n");
		xil_printf("------------------------------------------------------------------- \r\n\r\n");
		Error = 0;
		Done = 0;
	//	select = menu();
    }
    print("-- Exiting main() --\r\n");
    return 0;
}


