
BUILD_NAME = /home/rocky/Repositories/uvm/apb2spi
QVH_HOME = /opt/intelFPGA/20.1/modelsim_ase/linux/
RTL_DIR =  ${BUILD_NAME}/rtl
RTL_INC =  +incdir+${RTL_DIR}
APB_INC =  +incdir+${BUILD_NAME}/tb/env/apb_agent
SPI_INC =  +incdir+${BUILD_NAME}/tb/env/spi_agent
ENV_INC =  +incdir+${BUILD_NAME}/tb/env
TESTS_INC = +incdir+${BUILD_NAME}/tb/tests

UVM_SRC = /opt/intelFPGA/20.1/modelsim_ase/verilog_src/uvm-1.2/src

WORK : clean
	vlib work

RTL : WORK
	vlog -sv ${RTL_INC} ${RTL_DIR}/APB_SLAVE.v ${RTL_DIR}/APB_SPI_Top.v

TB : RTL
	#vlog -sv ${RTL_INC} ${APB_INC} ${SPI_INC} ${ENV_INC} ${TESTS_INC} tb_top.sv
	vlog -sv ${RTL_INC} ${APB_INC} ${SPI_INC} ${ENV_INC} ${TESTS_INC} -L uvm +incdir+${UVM_SRC}+${ENV_INC} ${UVM_SRC}/uvm_pkg.sv tb_top.sv ${UVM_SRC}/dpi/uvm_dpi.cc -ccflags -DQUESTA

SIM : TB
	#${qverilog} -sv ${RTL_INC} ${APB_INC} ${SPI_INC} ${ENV_INC} ${ENV_SRC_INC} ${TESTS_INC} tb_top.sv -R -sv_lib ${QVH_HOME}/uvm_dpi -c -do "run -all; q" -l questa.log
	#vsim -novopt ${RTL_INC} ${APB_INC} ${SPI_INC} ${ENV_INC} ${ENV_SRC_INC} ${TESTS_INC} tb_top -sv_lib ${QVH_HOME}/uvm_dpi -c -do "run -all; q" -l vsim.log
	vsim ${RTL_INC} ${APB_INC} ${SPI_INC} ${ENV_INC} ${ENV_SRC_INC} ${TESTS_INC} tb_top -c -do "run -all; q" -l vsim.log


clean:
	rm -rf work vlib.log vlog.log vsim.log
	
	
