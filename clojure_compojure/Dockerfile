FROM clojure

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN ["lein", "deps"]

CMD ["lein", "run", "-m", "openwhisk-clojure-example.core"]
