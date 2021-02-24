<div align="center">
    <img width="200" height="200" src="https://raw.githubusercontent.com/rules-proto-grpc/rules_proto_grpc/master/internal/resources/logo.svg">
    <h1>Protobuf and gRPC rules for <a href="https://bazel.build">Bazel</a></h1>
</div>

<div align="center">
    <a href="https://bazel.build">Bazel</a> rules for building <a href="https://developers.google.com/protocol-buffers">Protocol Buffers</a> ± <a href="https://grpc.io/">gRPC</a> code and libraries from <a href="https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library">proto_library</a> targets<br><br>
    <a href="https://buildkite.com/bazel/rules-proto-grpc-rules-proto-grpc"><img src="https://badge.buildkite.com/a0c88e60f21c85a8bb53a8c73175aebd64f50a0d4bacbdb038.svg?branch=master"></a>
    <a href="https://github.com/rules-proto-grpc/rules_proto_grpc/actions"><img src="https://github.com/rules-proto-grpc/rules_proto_grpc/workflows/CI/badge.svg"></a>
    <img src="https://img.shields.io/github/license/rules-proto-grpc/rules_proto_grpc.svg">
</div>


## Announcements 📣

#### 2021/02/21 - Version 3.0.0

[Version 3.0.0 has been released](https://github.com/rules-proto-grpc/rules_proto_grpc/releases/tag/3.0.0)
with updated Protobuf and gRPC versions and a number of major improvements. For some languages this may not be a
drop-in replacement and it may be necessary to update your WORKSPACE file due to changes in dependencies; please see
the above linked release notes for details or the language specific rules pages. If you discover any problems with the
new release, please [open a new issue](https://github.com/rules-proto-grpc/rules_proto_grpc/issues/new),
[create a discussion](https://github.com/rules-proto-grpc/rules_proto_grpc/discussions/new) or otherwise check in the
[#proto channel](https://bazelbuild.slack.com/archives/CKU1D04RM) on Bazel Slack.

#### 2021/02/09 - Bazel Version 4

Version 4.0 of Bazel has been released recently and is supported without update for most languages. Changes for full
Bazel 4.0 compatibility and updated dependencies are in progress.


## Contents

- [Overview](#overview)
- [Installation](#installation)
- [Rules](#rules)
    - [Android](/android/README.md)
    - [C](/c/README.md)
    - [C++](/cpp/README.md)
    - [C#](/csharp/README.md)
    - [D](/d/README.md)
    - [Documentation](/doc/README.md)
    - [Go](/go/README.md)
    - [grpc-gateway](/grpc-gateway/README.md)
    - [Java](/java/README.md)
    - [JavaScript](/js/README.md)
    - [Objective-C](/objc/README.md)
    - [PHP](/php/README.md)
    - [Python](/python/README.md)
    - [Ruby](/ruby/README.md)
    - [Rust](/rust/README.md)
    - [Scala](/scala/README.md)
    - [Swift](/swift/README.md)
- [Example Usage](#example-usage)
- [Developers](#developers)
    - [Code Layout](#code-layout)
    - [Rule Generation](#rule-generation)
    - [Developing Custom Plugins](#developing-custom-plugins)
- [License](#license)
- [Contributing](#contributing)


## Overview

These rules provide [Protocol Buffers (Protobuf)](https://developers.google.com/protocol-buffers/) and
[gRPC](https://grpc.io/) rules for a range of languages and services.

Each supported language (`{lang}` below) is generally split into four rule flavours:

- `{lang}_proto_compile`: Provides generated files from the Protobuf `protoc` plugin for the language. e.g for C++ this
  provides the generated `*.pb.cc` and `*.pb.h` files.

- `{lang}_proto_library`: Provides a language-specific library from the generated Protobuf `protoc` plugin outputs,
  along with necessary dependencies. e.g for C++ this provides a Bazel native `cpp_library` created  from the generated
  `*.pb.cc` and `*pb.h` files, with the Protobuf library linked. For languages that do not have a 'library' concept,
  this rule may not exist.

- `{lang}_grpc_compile`: Provides generated files from both the Protobuf and gRPC `protoc` plugins for the language.
  e.g for C++ this provides the generated `*.pb.cc`, `*.grpc.pb.cc`, `*.pb.h` and `*.grpc.pb.h` files.

- `{lang}_grpc_library`: Provides a language-specific library from the generated Protobuf and gRPC `protoc` plugins
  outputs, along with necessary dependencies. e.g for C++ this provides a Bazel native `cpp_library` created from the
  generated `*.pb.cc`, `*.grpc.pb.cc`, `*.pb.h` and `*.grpc.pb.h` files, with the Protobuf and gRPC libraries linked.
  For languages that do not have a 'library' concept, this rule may not exist.

Therefore, if you are solely interested in the generated source code files, use the `{lang}_{proto|grpc}_compile`
rules. Otherwise, if you want a ready-to-go library, use the `{lang}_{proto|grpc}_library` rules.


## Installation

Add `rules_proto_grpc` to your `WORKSPACE` file and then look at the language specific examples linked below:

```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_proto_grpc",
    urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/archive/3.0.0.tar.gz"],
    sha256 = "f9b50e672870fe5d60b8b2f3cd1731ceb89a9edef3513d81ba7f7c0d2991b51f",
    strip_prefix = "rules_proto_grpc-3.0.0",
)

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_toolchains", "rules_proto_grpc_repos")
rules_proto_grpc_toolchains()
rules_proto_grpc_repos()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
rules_proto_dependencies()
rules_proto_toolchains()
```

It is recommended that you use the tagged releases for stable rules. Master is intended to be 'ready-to-use', but may be
unstable at certain periods. To be notified of new releases, you can use GitHub's 'Watch Releases Only' on the
repository.

> **Important**: You will also need to follow instructions in the language-specific `README.md` for additional workspace
> dependencies that may be required.


## Rules

| Language | Rule | Description
| ---: | :--- | :--- |
| [Android](/android) | [android_proto_compile](/android#android_proto_compile) | Generates an Android protobuf `.jar` file ([example](/example/android/android_proto_compile)) |
| [Android](/android) | [android_grpc_compile](/android#android_grpc_compile) | Generates Android protobuf and gRPC `.jar` files ([example](/example/android/android_grpc_compile)) |
| [Android](/android) | [android_proto_library](/android#android_proto_library) | Generates an Android protobuf library using `android_library` from `rules_android` ([example](/example/android/android_proto_library)) |
| [Android](/android) | [android_grpc_library](/android#android_grpc_library) | Generates Android protobuf and gRPC library using `android_library` from `rules_android` ([example](/example/android/android_grpc_library)) |
| [C](/c) | [c_proto_compile](/c#c_proto_compile) | Generates C protobuf `.h` & `.c` files ([example](/example/c/c_proto_compile)) |
| [C](/c) | [c_proto_library](/c#c_proto_library) | Generates a C protobuf library using `cc_library`, with dependencies linked ([example](/example/c/c_proto_library)) |
| [C++](/cpp) | [cpp_proto_compile](/cpp#cpp_proto_compile) | Generates C++ protobuf `.h` & `.cc` files ([example](/example/cpp/cpp_proto_compile)) |
| [C++](/cpp) | [cpp_grpc_compile](/cpp#cpp_grpc_compile) | Generates C++ protobuf and gRPC `.h` & `.cc` files ([example](/example/cpp/cpp_grpc_compile)) |
| [C++](/cpp) | [cpp_proto_library](/cpp#cpp_proto_library) | Generates a C++ protobuf library using `cc_library`, with dependencies linked ([example](/example/cpp/cpp_proto_library)) |
| [C++](/cpp) | [cpp_grpc_library](/cpp#cpp_grpc_library) | Generates a C++ protobuf and gRPC library using `cc_library`, with dependencies linked ([example](/example/cpp/cpp_grpc_library)) |
| [C#](/csharp) | [csharp_proto_compile](/csharp#csharp_proto_compile) | Generates C# protobuf `.cs` files ([example](/example/csharp/csharp_proto_compile)) |
| [C#](/csharp) | [csharp_grpc_compile](/csharp#csharp_grpc_compile) | Generates C# protobuf and gRPC `.cs` files ([example](/example/csharp/csharp_grpc_compile)) |
| [C#](/csharp) | [csharp_proto_library](/csharp#csharp_proto_library) | Generates a C# protobuf library using `csharp_library` from `rules_dotnet`. Note that the library name must end in `.dll` ([example](/example/csharp/csharp_proto_library)) |
| [C#](/csharp) | [csharp_grpc_library](/csharp#csharp_grpc_library) | Generates a C# protobuf and gRPC library using `csharp_library` from `rules_dotnet`. Note that the library name must end in `.dll` ([example](/example/csharp/csharp_grpc_library)) |
| [D](/d) | [d_proto_compile](/d#d_proto_compile) | Generates D protobuf `.d` files ([example](/example/d/d_proto_compile)) |
| [D](/d) | [d_proto_library](/d#d_proto_library) | Generates a D protobuf library using `d_library` from `rules_d` ([example](/example/d/d_proto_library)) |
| [Documentation](/doc) | [doc_docbook_compile](/doc#doc_docbook_compile) | Generates DocBook `.xml` documentation file ([example](/example/doc/doc_docbook_compile)) |
| [Documentation](/doc) | [doc_html_compile](/doc#doc_html_compile) | Generates `.html` documentation file ([example](/example/doc/doc_html_compile)) |
| [Documentation](/doc) | [doc_json_compile](/doc#doc_json_compile) | Generates `.json` documentation file ([example](/example/doc/doc_json_compile)) |
| [Documentation](/doc) | [doc_markdown_compile](/doc#doc_markdown_compile) | Generates Markdown `.md` documentation file ([example](/example/doc/doc_markdown_compile)) |
| [Go](/go) | [go_proto_compile](/go#go_proto_compile) | Generates Go protobuf `.go` files ([example](/example/go/go_proto_compile)) |
| [Go](/go) | [go_grpc_compile](/go#go_grpc_compile) | Generates Go protobuf and gRPC `.go` files ([example](/example/go/go_grpc_compile)) |
| [Go](/go) | [go_proto_library](/go#go_proto_library) | Generates a Go protobuf library using `go_library` from `rules_go` ([example](/example/go/go_proto_library)) |
| [Go](/go) | [go_grpc_library](/go#go_grpc_library) | Generates a Go protobuf and gRPC library using `go_library` from `rules_go` ([example](/example/go/go_grpc_library)) |
| [grpc-gateway](/grpc-gateway) | [gateway_grpc_compile](/grpc-gateway#gateway_grpc_compile) | Generates grpc-gateway `.go` files ([example](/example/grpc-gateway/gateway_grpc_compile)) |
| [grpc-gateway](/grpc-gateway) | [gateway_openapiv2_compile](/grpc-gateway#gateway_openapiv2_compile) | Generates grpc-gateway OpenAPI v2 `.json` files ([example](/example/grpc-gateway/gateway_openapiv2_compile)) |
| [grpc-gateway](/grpc-gateway) | [gateway_grpc_library](/grpc-gateway#gateway_grpc_library) | Generates grpc-gateway library files ([example](/example/grpc-gateway/gateway_grpc_library)) |
| [Java](/java) | [java_proto_compile](/java#java_proto_compile) | Generates a Java protobuf srcjar file ([example](/example/java/java_proto_compile)) |
| [Java](/java) | [java_grpc_compile](/java#java_grpc_compile) | Generates a Java protobuf and gRPC srcjar file ([example](/example/java/java_grpc_compile)) |
| [Java](/java) | [java_proto_library](/java#java_proto_library) | Generates a Java protobuf library using `java_library` ([example](/example/java/java_proto_library)) |
| [Java](/java) | [java_grpc_library](/java#java_grpc_library) | Generates a Java protobuf and gRPC library using `java_library` ([example](/example/java/java_grpc_library)) |
| [JavaScript](/js) | [js_proto_compile](/js#js_proto_compile) | Generates JavaScript protobuf `.js` and `.d.ts` files ([example](/example/js/js_proto_compile)) |
| [JavaScript](/js) | [js_grpc_node_compile](/js#js_grpc_node_compile) | Generates JavaScript protobuf and gRPC-node `.js` and `.d.ts` files ([example](/example/js/js_grpc_node_compile)) |
| [JavaScript](/js) | [js_grpc_web_compile](/js#js_grpc_web_compile) | Generates JavaScript protobuf and gRPC-Web `.js` and `.d.ts` files ([example](/example/js/js_grpc_web_compile)) |
| [JavaScript](/js) | [js_proto_library](/js#js_proto_library) | Generates a JavaScript protobuf library using `js_library` from `rules_nodejs` ([example](/example/js/js_proto_library)) |
| [JavaScript](/js) | [js_grpc_node_library](/js#js_grpc_node_library) | Generates a Node.js protobuf + gRPC-node library using `js_library` from `rules_nodejs` ([example](/example/js/js_grpc_node_library)) |
| [JavaScript](/js) | [js_grpc_web_library](/js#js_grpc_web_library) | Generates a JavaScript protobuf + gRPC-Web library using `js_library` from `rules_nodejs` ([example](/example/js/js_grpc_web_library)) |
| [Objective-C](/objc) | [objc_proto_compile](/objc#objc_proto_compile) | Generates Objective-C protobuf `.m` & `.h` files ([example](/example/objc/objc_proto_compile)) |
| [Objective-C](/objc) | [objc_grpc_compile](/objc#objc_grpc_compile) | Generates Objective-C protobuf and gRPC `.m` & `.h` files ([example](/example/objc/objc_grpc_compile)) |
| [Objective-C](/objc) | [objc_proto_library](/objc#objc_proto_library) | Generates an Objective-C protobuf library using `objc_library` ([example](/example/objc/objc_proto_library)) |
| [Objective-C](/objc) | [objc_grpc_library](/objc#objc_grpc_library) | Generates an Objective-C protobuf and gRPC library using `objc_library` ([example](/example/objc/objc_grpc_library)) |
| [PHP](/php) | [php_proto_compile](/php#php_proto_compile) | Generates PHP protobuf `.php` files ([example](/example/php/php_proto_compile)) |
| [PHP](/php) | [php_grpc_compile](/php#php_grpc_compile) | Generates PHP protobuf and gRPC `.php` files ([example](/example/php/php_grpc_compile)) |
| [Python](/python) | [python_proto_compile](/python#python_proto_compile) | Generates Python protobuf `.py` files ([example](/example/python/python_proto_compile)) |
| [Python](/python) | [python_grpc_compile](/python#python_grpc_compile) | Generates Python protobuf and gRPC `.py` files ([example](/example/python/python_grpc_compile)) |
| [Python](/python) | [python_grpclib_compile](/python#python_grpclib_compile) | Generates Python protobuf and grpclib `.py` files (supports Python 3 only) ([example](/example/python/python_grpclib_compile)) |
| [Python](/python) | [python_proto_library](/python#python_proto_library) | Generates a Python protobuf library using `py_library` from `rules_python` ([example](/example/python/python_proto_library)) |
| [Python](/python) | [python_grpc_library](/python#python_grpc_library) | Generates a Python protobuf and gRPC library using `py_library` from `rules_python` ([example](/example/python/python_grpc_library)) |
| [Python](/python) | [python_grpclib_library](/python#python_grpclib_library) | Generates a Python protobuf and grpclib library using `py_library` from `rules_python` (supports Python 3 only) ([example](/example/python/python_grpclib_library)) |
| [Ruby](/ruby) | [ruby_proto_compile](/ruby#ruby_proto_compile) | Generates Ruby protobuf `.rb` files ([example](/example/ruby/ruby_proto_compile)) |
| [Ruby](/ruby) | [ruby_grpc_compile](/ruby#ruby_grpc_compile) | Generates Ruby protobuf and gRPC `.rb` files ([example](/example/ruby/ruby_grpc_compile)) |
| [Ruby](/ruby) | [ruby_proto_library](/ruby#ruby_proto_library) | Generates a Ruby protobuf library using `ruby_library` from `rules_ruby` ([example](/example/ruby/ruby_proto_library)) |
| [Ruby](/ruby) | [ruby_grpc_library](/ruby#ruby_grpc_library) | Generates a Ruby protobuf and gRPC library using `ruby_library` from `rules_ruby` ([example](/example/ruby/ruby_grpc_library)) |
| [Rust](/rust) | [rust_proto_compile](/rust#rust_proto_compile) | Generates Rust protobuf `.rs` files ([example](/example/rust/rust_proto_compile)) |
| [Rust](/rust) | [rust_grpc_compile](/rust#rust_grpc_compile) | Generates Rust protobuf and gRPC `.rs` files ([example](/example/rust/rust_grpc_compile)) |
| [Rust](/rust) | [rust_proto_library](/rust#rust_proto_library) | Generates a Rust protobuf library using `rust_library` from `rules_rust` ([example](/example/rust/rust_proto_library)) |
| [Rust](/rust) | [rust_grpc_library](/rust#rust_grpc_library) | Generates a Rust protobuf and gRPC library using `rust_library` from `rules_rust` ([example](/example/rust/rust_grpc_library)) |
| [Scala](/scala) | [scala_proto_compile](/scala#scala_proto_compile) | Generates a Scala protobuf `.jar` file ([example](/example/scala/scala_proto_compile)) |
| [Scala](/scala) | [scala_grpc_compile](/scala#scala_grpc_compile) | Generates Scala protobuf and gRPC `.jar` file ([example](/example/scala/scala_grpc_compile)) |
| [Scala](/scala) | [scala_proto_library](/scala#scala_proto_library) | Generates a Scala protobuf library using `scala_library` from `rules_scala` ([example](/example/scala/scala_proto_library)) |
| [Scala](/scala) | [scala_grpc_library](/scala#scala_grpc_library) | Generates a Scala protobuf and gRPC library using `scala_library` from `rules_scala` ([example](/example/scala/scala_grpc_library)) |
| [Swift](/swift) | [swift_proto_compile](/swift#swift_proto_compile) | Generates Swift protobuf `.swift` files ([example](/example/swift/swift_proto_compile)) |
| [Swift](/swift) | [swift_grpc_compile](/swift#swift_grpc_compile) | Generates Swift protobuf and gRPC `.swift` files ([example](/example/swift/swift_grpc_compile)) |
| [Swift](/swift) | [swift_proto_library](/swift#swift_proto_library) | Generates a Swift protobuf library using `swift_library` from `rules_swift` ([example](/example/swift/swift_proto_library)) |
| [Swift](/swift) | [swift_grpc_library](/swift#swift_grpc_library) | Generates a Swift protobuf and gRPC library using `swift_library` from `rules_swift` ([example](/example/swift/swift_grpc_library)) |

## Example Usage

These steps walk through the actions required to go from a raw `.proto` file to a C++ library. Other languages will have
a similar high-level layout.

**Step 1**: Write a Protocol Buffer .proto file (example: `thing.proto`):

```proto
syntax = "proto3";

package example;

import "google/protobuf/any.proto";

message Thing {
    string name = 1;
    google.protobuf.Any payload = 2;
}
```

**Step 2**: Write a `BAZEL.build` file with a
[`proto_library`](https://docs.bazel.build/versions/master/be/protocol-buffer.html#proto_library) target:

```starlark
proto_library(
    name = "thing_proto",
    srcs = ["thing.proto"],
    deps = ["@com_google_protobuf//:any_proto"],
)
```

In this example we have a dependency on a well-known type `any.proto`, hence the `proto_library` to `proto_library`
dependency (`"@com_google_protobuf//:any_proto"`)

**Step 3**: Add a `cpp_proto_compile` target

> NOTE: In this example `thing.proto` does not include service definitions (gRPC). For protos with services, use the
> `cpp_grpc_compile` rule instead.

```starlark
# BUILD.bazel
load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_compile")

cpp_proto_compile(
    name = "cpp_thing_proto",
    protos = [":thing_proto"],
)
```

But wait, before we can build this, we need to load the dependencies necessary for this rule
(see [cpp/README.md](/cpp/README.md)):

**Step 4**: Load the workspace macro corresponding to the build rule.

```starlark
# WORKSPACE
load("@rules_proto_grpc//cpp:repositories.bzl", "cpp_repos")

cpp_repos()
```

We're now ready to build the target:

**Step 5**: Build it!

```sh
$ bazel build //example/proto:cpp_thing_proto
Target //example/proto:cpp_thing_proto up-to-date:
  bazel-genfiles/example/proto/cpp_thing_proto/example/proto/thing.pb.h
  bazel-genfiles/example/proto/cpp_thing_proto/example/proto/thing.pb.cc
```

If we were only interested in the generated files, the `cpp_grpc_compile` rule would be fine. However, for
convenience we'd rather have the outputs compiled into a C++ library. To do that, let's change the  rule from
`cpp_proto_compile` to `cpp_proto_library`:

```starlark
# BUILD.bazel
load("@rules_proto_grpc//cpp:defs.bzl", "cpp_proto_library")

cpp_proto_library(
    name = "cpp_thing_proto",
    protos = [":thing_proto"],
)
```

```sh
$ bazel build //example/proto:cpp_thing_proto
Target //example/proto:cpp_thing_proto up-to-date:
  bazel-bin/example/proto/libcpp_thing_proto.a
  bazel-bin/example/proto/libcpp_thing_proto.so  bazel-genfiles/example/proto/cpp_thing_proto/example/proto/thing.pb.h
  bazel-genfiles/example/proto/cpp_thing_proto/example/proto/thing.pb.cc
```

This way, we can use `//example/proto:cpp_thing_proto` as a dependency of any other `cc_library` or `cc_binary` target
as per normal.

> NOTE: The `cpp_proto_library` target implicitly calls `cpp_proto_compile`, and we can access that rule's by adding
> `_pb` at the end of the target name, like `bazel build //example/proto:cpp_thing_proto_pb`


## Developers

### Code Layout

Each language `{lang}` has a top-level subdirectory that contains:

1. `{lang}/README.md`: Generated documentation for the language rules

1. `{lang}/repositories.bzl`: Macro functions that declare repository rule dependencies for that language

2. `{lang}/{rule}.bzl`: Rule implementations of the form `{lang}_{kind}_{type}`, where `kind` is one of `proto|grpc` and
   `type` is one of `compile|library`

3. `{lang}/BUILD.bazel`: `proto_plugin()` declarations for the available plugins for the language

4. `example/{lang}/{rule}/`: Generated `WORKSPACE` and `BUILD.bazel` demonstrating standalone usage of the rules

5. `{lang}/example/routeguide/`: Example routeguide example implementation, if possible


### Rule Generation

To help maintain consistency of the rule implementations and documentation, all of the rule implementations are
generated by the tool `//tools/rulegen`. Changes in the main `README.md` should be placed in
`tools/rulegen/README.header.md` or `tools/rulegen/README.footer.md`. Changes to generated rules should be put in the
source files (example: `tools/rulegen/java.go`).


### Developing Custom Plugins

Generally, follow the pattern seen in the multiple language examples in this
repository.  The basic idea is:

1. Load the plugin rule: `load("@rules_proto_grpc//:defs.bzl", "proto_plugin")`
2. Define the rule, giving it a `name`, `options` (not mandatory), `tool` and `outputs`. `tool` is a label that refers
   to the binary executable for the plugin itself
3. Choose your output type (pick one!):
    - `outputs`: A list of strings patterns that predicts the pattern of files generated by the plugin. For plugins that
      produce one output file per input proto file
    - `out`: The name of a single output file generated by the plugin
    - `output_directory`: Set to true if your plugin generates files in a non-predictable way. e.g. if the output paths
      depend on the service names within the files
4. Create a compilation rule and aspect using the following template:

```starlark
load("@rules_proto//proto:defs.bzl", "ProtoInfo")
load(
    "@rules_proto_grpc//:defs.bzl",
    "ProtoLibraryAspectNodeInfo",
    "ProtoPluginInfo",
    "proto_compile_aspect_attrs",
    "proto_compile_aspect_impl",
    "proto_compile_attrs",
    "proto_compile_impl",
)

# Create aspect
example_aspect = aspect(
    implementation = proto_compile_aspect_impl,
    provides = [ProtoLibraryAspectNodeInfo],
    attr_aspects = ["deps"],
    attrs = dict(
        proto_compile_aspect_attrs,
        _plugins = attr.label_list(
            doc = "List of protoc plugins to apply",
            providers = [ProtoPluginInfo],
            default = [
                Label("//<LABEL OF YOUR PLUGIN>"),
            ],
        ),
        _prefix = attr.string(
            doc = "String used to disambiguate aspects when generating outputs",
            default = "example_aspect",
        ),
    ),
    toolchains = ["@rules_proto_grpc//protobuf:toolchain_type"],
)

# Create compile rule to apply aspect
_rule = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        protos = attr.label_list(
            mandatory = False,  # TODO: set to true in 4.0.0 when deps removed below
            providers = [ProtoInfo],
            doc = "List of labels that provide a ProtoInfo (such as rules_proto proto_library)",
        ),
        deps = attr.label_list(
            mandatory = False,
            providers = [ProtoInfo, ProtoLibraryAspectNodeInfo],
            aspects = [example_aspect],
            doc = "DEPRECATED: Use protos attr",
        ),
        _plugins = attr.label_list(
            doc = "List of protoc plugins to apply",
            providers = [ProtoPluginInfo],
            default = [
                Label("//<LABEL OF YOUR PLUGIN>"),
            ],
        ),
    ),
    toolchains = [str(Label("//protobuf:toolchain_type"))],
)

# Create macro for converting attrs and passing to compile
def example_compile(**kwargs):
    _rule(
        verbose_string = "{}".format(kwargs.get("verbose", 0)),
        **kwargs
    )


```


## License

This project is derived from [stackb/rules_proto](https://github.com/stackb/rules_proto) under the
[Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0) license and  this project therefore maintains the terms of that
license


## Contributing

Contributions are very welcome. Please see [CONTRIBUTING.md](/docs/CONTRIBUTING.md) for further details.
