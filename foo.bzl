"""Rules that execute shell commands to do simple transformations."""

def _compile_dpi_lib_impl(ctx):
    #headers = ctx.files.hdrs
    srcs = ctx.files.srcs
    #inputs = depset(srcs, transitive=[headers])
    in_files = [src.path for src in srcs]
    out_file = ctx.actions.declare_file(ctx.label.name + ".bin")

    args = ctx.actions.args()
    #args.add_joined("-I", headers, join_with=",")
    args.add_joined(in_files, join_with=" ")
    args.add("-o", out_file)
    args.add("-m64")

    ctx.actions.run(
        outputs = [out_file],
        inputs = ctx.files.srcs,
        arguments = [args],
        executable = "gcc"
    )
    return[DefaultInfo(files = depset([out_file]))]

compile_dpi_lib = rule(
    implementation = _compile_dpi_lib_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = [".c"]),
        #"hdrs": attr.label_list(allow_files = [".h"])
    }
)