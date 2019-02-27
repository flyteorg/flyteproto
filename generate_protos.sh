DIR=`pwd`
docker run -v $DIR:/defs namely/protoc-all -d api/core/v1/ -l python -i .
