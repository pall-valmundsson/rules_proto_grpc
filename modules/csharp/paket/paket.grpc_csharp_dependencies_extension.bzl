"Generated"

load(":paket.grpc_csharp_dependencies.bzl", _grpc_csharp_dependencies = "grpc_csharp_dependencies")

def _grpc_csharp_dependencies_impl(_ctx):
    _grpc_csharp_dependencies()

grpc_csharp_dependencies_extension = module_extension(
    implementation = _grpc_csharp_dependencies_impl,
)
