FROM --platform=linux/amd64 ubuntu:22.04 as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential cmake git pkg-config uuid-dev clang

COPY . /repo
WORKDIR /repo/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/install
RUN make -j8
RUN make install
RUN clang++ /repo/mayhem/fuzz_ctuStrtod.cpp -fsanitize=fuzzer,address /repo/build/c/shared/source/libctutil.a -o /fuzz

FROM ubuntu:22.04 as package
COPY --from=builder /repo/build/bin/makeotfexe /
COPY --from=builder /fuzz /fuzz_ctuStrtod
