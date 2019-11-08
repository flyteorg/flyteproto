import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="k8s-proto",
    version="0.0.3",
    maintainer="lyft",
    maintainer_email='dev@lyft.com',
    description="Generated kubernetes proto code",
    license="Apache License Version 2.0",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/lyft/flyteproto",
    packages=setuptools.find_packages(),
    install_requires=[
         "protobuf>=3.6.0,<4.0.0",
    ],
)
