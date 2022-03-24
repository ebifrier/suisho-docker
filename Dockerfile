FROM ubuntu:20.04 as BUILD

# tzdataインストール時のユーザー入力を出さないようします。
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential clang

WORKDIR /work
ADD . /work

RUN cd ./source && make -j8


FROM ubuntu:20.04

WORKDIR /work
ADD . /work
COPY --from=BUILD /work/source/YaneuraOu-by-gcc /work/YaneuraOu

CMD ["./YaneuraOu", ""]
