FROM erlang:18.2.3

ADD . /openwhisk_action

RUN cd /openwhisk_action && rebar get-deps compile

EXPOSE 8080
CMD ["/bin/bash", "-lc", "cd /openwhisk_action && erl -pa ebin deps/*/ebin -noshell -noinput -s openwhisk_erl_cowboy"]
