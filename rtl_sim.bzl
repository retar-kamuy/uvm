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
    },
)

def _vmap_impl(ctx):
    for lib in ctx.files.libs:
        ctx.actions.run_shell(
            inputs = [lib],
            outputs = [ctx.outputs.ini_filepath],
            arguments = [
                #ctx.files.libs[0].basename,
                lib.basename,
                lib.path,
                ctx.outputs.ini_filepath.path,
            ],
            use_default_shell_env=True,
            command = "vmap $1 $2 >  && cat modelsim.ini > $3",
        )

    return[DefaultInfo(files = depset([ctx.outputs.ini_filepath]))]

vmap = rule(
    implementation = _vmap_impl,
    attrs = {
        "libs": attr.label_list(
            providers = [DefaultInfo],
            allow_files = True,
            mandatory = True,
        ),
    },
    outputs = {"ini_filepath": "modelsim.ini"}
)

def _vsim_impl(ctx):
    args = ctx.actions.args()
    args.add("-c")
    args.add_joined("-L", [file.path for file in ctx.files.libs], join_with=" ")
    #args.add_all(["-L %s" % file.basename for file in ctx.files.libs])
    #args.add("-lib", "work")
    args.add_all(["-wlf", "wave.wlf"])
    args.add_all(["-do", "add wave -r /*; run -all; quit;"])
    args.add_all(["-l", ctx.outputs.log_name])
    args.add("bazel-out/k8-fastbuild/bin/work.half_adder_tb")

    ctx.actions.run_shell(
        inputs = ctx.files.libs,
        outputs = [ctx.outputs.log_name],
        #arguments = [args],
        use_default_shell_env=True,
        command = "ls -l",
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
        #"inifile": attr.output(),
    },
)