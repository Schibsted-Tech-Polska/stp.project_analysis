if [ "$(expr substr $(uname -s) 1 6)" == "Darwin" ];then
echo Darwin rulez
else
echo Unix is king
fi