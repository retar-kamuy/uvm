load(":rtl_sim.bzl", "vlog", "vsim")

vlog(
    name = "vlog_dut",
    library_name = "lib_dut",
    srcs = ["src/half_adder.sv"],
    log_name = "vlog_dut.log",
)

vlog(
    name = "vlog_tb",
    library_name = "lib_tb",
    srcs = ["tb/half_adder_tb.sv"],
    opts = [
        "-timescale 1ns/1ns",
        "-mfcu",
        "-suppress 2181",
    ],
    log_name = "vlog_tb.log",
)

vsim(
    name = "vsim",
    libs = [":vlog_dut", ":vlog_tb"],
    log_name = "vsim.log",
)