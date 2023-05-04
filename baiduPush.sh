#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

pwd

echo `pwd`

ls  -alrt

curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://yinlingchaoliu.gitee.io&token=OdkhJGLdzCkQXjuc"

# https://ziyuan.baidu.com/linksubmit/index