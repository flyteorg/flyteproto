# flyteproto

Flyteproto is a collection of generated [protocol buffer](https://developers.google.com/protocol-buffers/) bindings for kubernetes generated [protobuf definitions](https://github.com/kubernetes/api/blob/master/core/v1/generated.proto). 

## Contents

### k8s
Generated protobuf code (currently python only), complete with imports synced from k8s.io/apimachinery in [kubernetes/apimachinery](https://github.com/kubernetes/apimachinery)

### k8s.io
Core and imported protobuf definitions in a path that matches their declared packages. Use these to generate protobufs that import the core kubernetes protos.

## Usage
Run `generate.sh` to regenerate protobuf code.

To use kubernetes protobuf definitions in your own protobufs, pass the `k8s.io` dir as an input directory to protoc:
```
protoc -I=k8s.io/ [OPTION] PROTO_FILES
