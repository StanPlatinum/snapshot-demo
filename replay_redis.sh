## original path: hello_c
## dest path: hello_replay
# path="hello_c"
path=bash_redis

postfix="_replay"
path_replay=${path}${postfix}

echo "Replaying ..."
cd ${path_replay}

pushd occlum_instance

occlum run /bin/occlum_bash.sh

popd
