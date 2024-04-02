#cd xssh
export COMMIT=$@
if [[ $COMMIT != "" ]];then
git commit -a -m "$@"
git push -u origin main
else
echo "缺少提交信息，请在参数中添加"
fi
