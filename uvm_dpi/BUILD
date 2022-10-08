#load("@uvm//:questa.bzl", "uvm_compile")

cc_library(
    name = "dpi_lib",
    srcs = ["verilog_src/uvm-1.2/src/dpi/uvm_dpi.cc"],
    hdrs = glob(["include/*.h"] + ["verilog_src/uvm-1.2/src/dpi/*"]),
    #hdrs = glob(["src/dpi/*"] + ["include/*.h"]),
    includes = ["include"],
    visibility = ["//visibility:public"],
    copts = ["-m64", "-fPIC", "-DQUESTA", "-g", "-W", "-shared", "-x c"],
)

#uvm_compile(
#    name = "vlog_uvm",
#    srcs = ["verilog_src/uvm-1.2/src/uvm.sv"],
#    hdrs = glob(["verilog_src/uvm-1.2/src/*.sv"] + ["verilog_src/uvm-1.2/src/*.svh"]),
#    visibility = ["//visibility:public"],
#)