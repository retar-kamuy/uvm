load(":foo.bzl", "compile_dpi_lib")

#compile_dpi_lib(
#    name = "dpi_lib",
#    #hdrs = glob(["C:\\intelFPGA\\20.1\\modelsim_ase\\include\\*.h"]),
#    srcs = ["swap.c"],
#)

cc_library(
    name = "dpi_lib",
    srcs = ["src/dpi/uvm_dpi.cc"],
    hdrs = glob(["src/dpi/*"] + ["include/*.h"]),
    includes = ["/opt/intelFPGA/20.1/modelsim_ase/include",
                "src/dpi"],
    visibility = ["//visibility:public"],
    copts = ["-m64", "-fPIC", "-DQUESTA", "-g", "-W", "-shared", "-x c"]
)
