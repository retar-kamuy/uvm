load(":rtl_sim.bzl", "vlog")

vlog(
    name = "vlog_dut",
    libname = "lib_dut",
    srcs = ["src/half_adder.sv"],
    vlogopt = [
        "-mfcu",
        "-suppress 2181",
    ],
)

vlog(
    name = "vlog_tb",
    libname = "lib_tb",
    srcs = ["tb/half_adder_tb.sv"],
    vlogopt = [
        "-timescale 1ns/1ns",
        "-mfcu",
        "-suppress 2181",
    ],
)
