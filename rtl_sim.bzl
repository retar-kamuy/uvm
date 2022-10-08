"""Rules that execute Questa simulation."""

def _vlog_impl(ctx):
    args = ctx.actions.args()
    args.add(ctx.outputs.library_name)
    args.add(ctx.outputs.log_name)
    args.add( " ".join([opt for opt in ctx.attr.opts]) )
    args.add( " ".join([src.path for src in ctx.files.srcs]) )

    ctx.actions.run_shell(
        inputs = ctx.files.srcs,
        outputs = [ctx.outputs.library_name, ctx.outputs.log_name],
        arguments = [args],
        use_default_shell_env=True,
        command = "vlog -work $1 -l $2 $3 $4",
    )

    runfiles = ctx.runfiles(files = [ctx.outputs.library_name])

    return[DefaultInfo(files = depset([ctx.outputs.library_name]), runfiles = runfiles)]

def _vsim_impl(ctx):
    print(ctx.files.libs)
    print("".join([file.path for file in ctx.files.libs]))

    args = ctx.actions.args()
    args.add("-c")
    args.add_joined("-L", [file.basename for file in ctx.files.libs], join_with=" ")
    args.add_all(["-wlf", "wave.wlf"])
    args.add_all(["-do", "add wave -r /*; run -all; quit;"])
    args.add_all(["-l", ctx.outputs.log_name])
    args.add("bazel-out/k8-fastbuild/bin/lib_tb.half_adder_tb")

    ctx.actions.run(
        inputs = ctx.files.libs,
        outputs = [ctx.outputs.log_name],
        arguments = [args],
        use_default_shell_env=True,
        executable = "vsim",
    )

vlog = rule(
    implementation = _vlog_impl,
    attrs = {
        "library_name": attr.output(),
        "srcs": attr.label_list(
            allow_files = True,
            mandatory = True,
        ),
        "opts": attr.string_list(),
        "log_name": attr.output(),
    }
)

vsim = rule(
    implementation = _vsim_impl,
    attrs = {
        "libs": attr.label_list(
            providers = [DefaultInfo],
            allow_files = True,
            mandatory = True,
        ),
        "log_name": attr.output(),
    }
)