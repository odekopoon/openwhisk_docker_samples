FROM jimmycuadra/rust:1.6.0

ADD . /openwhisk_action

RUN cd /openwhisk_action && cargo build --release

EXPOSE 8080
CMD ["/openwhisk_action/target/release/openwhisk_rust_example"]
