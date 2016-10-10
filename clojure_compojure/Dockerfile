FROM clojure

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN ["lein", "deps"]

RUN ["touch", ".lein-fast-trampoline"]
#ENV LEIN_FAST_TRAMPOLINE y

CMD ["lein", "trampoline", "run", "-m", "openwhisk-clojure-example.core"]
