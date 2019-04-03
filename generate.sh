DIR=`pwd`

# Before running this make sure to init git submodules:
# git submodule init
# git submodule update

rm -rf k8s.io/

# Copy over all the kubernetes/apimachinery protos to where api/core/v1/generated.proto expects (k8s.io)
mkdir -p k8s.io/apimachinery/pkg/runtime/
cp kubernetes/apimachinery/pkg/runtime/generated.proto k8s.io/apimachinery/pkg/runtime/generated.proto
mkdir -p k8s.io/apimachinery/pkg/api/resource/
cp kubernetes/apimachinery/pkg/api/resource/generated.proto k8s.io/apimachinery/pkg/api/resource/generated.proto
mkdir -p k8s.io/apimachinery/pkg/util/intstr/
cp kubernetes/apimachinery/pkg/util/intstr/generated.proto k8s.io/apimachinery/pkg/util/intstr/generated.proto
mkdir -p k8s.io/apimachinery/pkg/runtime/schema/
cp kubernetes/apimachinery/pkg/runtime/schema/generated.proto k8s.io/apimachinery/pkg/runtime/schema/generated.proto
mkdir -p k8s.io/apimachinery/pkg/apis/meta/v1/
cp kubernetes/apimachinery/pkg/apis/meta/v1/generated.proto k8s.io/apimachinery/pkg/apis/meta/v1/generated.proto

# Generate imported protos in python
docker run -v $DIR:/defs namely/protoc-all -f k8s.io/apimachinery/pkg/runtime/generated.proto -l python -o gen
docker run -v $DIR:/defs namely/protoc-all -f k8s.io/apimachinery/pkg/api/resource/generated.proto -l python -o gen
docker run -v $DIR:/defs namely/protoc-all -f k8s.io/apimachinery/pkg/runtime/schema/generated.proto -l python -o gen
docker run -v $DIR:/defs namely/protoc-all -f k8s.io/apimachinery/pkg/util/intstr/generated.proto -l python -o gen
docker run -v $DIR:/defs namely/protoc-all -f k8s.io/apimachinery/pkg/apis/meta/v1/generated.proto -l python -o gen

# Generate core proto
mkdir -p k8s/io/api/core/v1/
cp kubernetes/api/core/v1/generated.proto k8s/io/api/core/v1/
docker run -v $DIR:/defs namely/protoc-all -f k8s/io/api/core/v1/generated.proto -l python -i . -o gen

# python is a pain with imports when it comes to filenames with "." in them
rm -rf k8s/io
mkdir -p k8s/io
mv gen/k8s/io/* k8s/io
touch k8s/__init__.py

# Also copy the core generated proto to its reference path for dependent proto definitions (that import core k8s protos).
mkdir -p k8s.io/api/core/v1/
cp kubernetes/api/core/v1/generated.proto k8s.io/api/core/v1/

# Clean up intermediate directories and files
rm -rf gen
