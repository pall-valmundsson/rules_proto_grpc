"""Generated definition of csharp_grpc_library."""

load("//:csharp_grpc_compile.bzl", "csharp_grpc_compile")
load("@rules_proto_grpc//:defs.bzl", "bazel_build_rule_common_attrs", "proto_compile_attrs")
load("@rules_dotnet//dotnet:defs.bzl", "csharp_library")

def csharp_grpc_library(name, target_frameworks, **kwargs):
    # Compile protos
    name_pb = name + "_pb"
    csharp_grpc_compile(
        name = name_pb,
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in proto_compile_attrs.keys() or
               k in bazel_build_rule_common_attrs
        }  # Forward args
    )

    # Create csharp library
    csharp_library(
        name = name,
        srcs = [name_pb],
        target_frameworks = target_frameworks,
        deps = GRPC_DEPS + kwargs.get("deps", []),
        **{
            k: v
            for (k, v) in kwargs.items()
            if k in bazel_build_rule_common_attrs
        }  # Forward Bazel common args
    )

GRPC_DEPS = [
    Label("@paket.grpc_csharp_dependencies//google.protobuf:google.protobuf"),
    Label("@paket.grpc_csharp_dependencies//grpc.net.client:grpc.net.client"),
    Label("@paket.grpc_csharp_dependencies//grpc.aspnetcore:grpc.aspnetcore"),
    Label("@paket.grpc_csharp_dependencies//grpc.core:grpc.core"),
    Label("@paket.grpc_csharp_dependencies//grpc.core.api:grpc.core.api"),
]
