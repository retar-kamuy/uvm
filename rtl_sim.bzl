"""Rules that execute Questa simulation."""

def _vlog_impl(ctx):
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
        "libname": attr.output(),
        "srcs": attr.label_list(
            allow_files = True,
            mandatory = True,
        ),
        "vlogopt": attr.string_list(),
    }
)