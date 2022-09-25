"""Rules that execute Questa simulation."""

def _vlib_impl(ctx):
    args = ctx.actions.args()
    args.add(ctx.outputs.library_name)

    ctx.actions.run(
        outputs = [ctx.outputs.library_name],
        arguments = [args],
        executable = "/opt/intelFPGA/22.2/questa_fse/bin/vlib",
    )
    return[DefaultInfo(files = depset([ctx.outputs.library_name]))]

def _vmap_impl(ctx):
    print(ctx.files.library_path)
    for str in ctx.files.library_path:
        print(str.path)
    print(ctx.files.library_path[0].path)
    args = ctx.actions.args()
    args.add(ctx.attr.library_name, ctx.files.library_path[0].path)
    #args.add(ctx.attr.library_name, "work")

    ctx.actions.run(
        outputs = [ctx.outputs.ini_filepath],
        arguments = [args],
        executable = "/opt/intelFPGA/22.2/questa_fse/bin/vmap",
    )

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

vlib = rule(
    implementation = _vlib_impl,
    attrs = {
        "library_name": attr.output(),
    }
)


vmap = rule(
    implementation = _vmap_impl,
    attrs = {
        "library_name": attr.string(),
        "library_path": attr.label(
            allow_single_file = True,
        ),
        "ini_filepath": attr.output(),
    }
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