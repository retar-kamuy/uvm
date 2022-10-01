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
        command = "/opt/intelFPGA/22.2/questa_fse/bin/vlog -work $1 -l $2 $3 $4",
    )

    return[DefaultInfo(files = depset([ctx.outputs.library_name]))]

def _vsim_impl(ctx):
    args = ctx.actions.args()
    args.add_all(ctx.files.srcs)
    args.add("-work", ctx.outputs.libname)

    for opt in ctx.attr.vlogopt:
        if " " in opt:
            args.add_all(opt.split(" "))
        else:
            args.add(opt)

    ctx.actions.run(
        inputs = ctx.files.srcs,
        outputs = [ctx.outputs.libname],
        arguments = [args],
        executable = "/opt/intelFPGA/22.2/questa_fse/bin/vlog",
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
