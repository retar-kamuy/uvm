"""Rules that execute shell commands to do simple transformations."""

def _uvm_compile_impl(ctx):
    headers = ctx.files.hdrs
    srcs = ctx.files.srcs
    #inputs = depset(srcs, transitive=[headers])
    inc_dirs = ["+incdir+" + header.path for header in headers]
    #out_file = ctx.acti-mfcu \
	-suppress 2181ons.declare_file(ctx.label.name + ".bin")
    #out_dir = ctx.actions.declare_directory(ctx.outputs.out.path)
    #out_file = ctx.actions.declare_file(ctx.outputs.out.path)

    args = ctx.actions.args()
    #args.add("-timescale", "1ns/1ns")
    #args.add("-mfcu")
    #args.add("-suppress", 2181)
    #args.add_all("-writetoplevels", ["questa.tops"])
    #args.add_all(inc_dirs)
    #args.add_all(srcs)
    #args.add("-l", "vlog.log")
    args.add(ctx.outputs.out)

    ctx.actions.run(
        #arguments = ["work"],
        #use_default_shell_env=True,
        #env ={'PATH': '/opt/intelFPGA/22.2/questa_fse/bin'},
        executable = "/opt/intelFPGA/22.2/questa_fse/bin/vlib",
        inputs = ctx.files.srcs,
        arguments = [args],
        outputs = [ctx.outputs.out],
        #executable = "/opt/intelFPGA/22.2/questa_fse/bin/vlib"
    )

    return[DefaultInfo(files = depset([ctx.outputs.out]))]

uvm_compile = rule(
    implementation = _uvm_compile_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "hdrs": attr.label_list(allow_files = True),
        "out": attr.output(mandatory = True),
    }

)