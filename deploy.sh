#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 是否自动部署
auto=""
if [ -z $1 ]; then
  auto=""    
else
  auto=`echo ci $1`
fi

push_addr="git@github.com:yinlingchaoliu/yinlingchaoliu.github.io.git"
push_branch=master # 推送的分支
user_name=`git log -1 --pretty=format:'%an'`
user_email=`git log -1 --pretty=format:'%ae'`

commit_info=`git describe --all --always --long`
dist_path=docs/.vuepress/dist # 打包生成的文件夹路径

mkdir -p $dist_path
#将readme 拷贝过去
cp README.MD $dist_path

# 生成静态文件
# yarn build

# 进入生成的文件夹
cd $dist_path

git init
git config user.name ${user_name}
git config user.email ${user_email}
git add -A
git commit -m "$auto deploy, $commit_info"

# 本地构建
if [ -z $auto ]; then
  git push -f $push_addr HEAD:$push_branch
else  # 自动化构建
  access_url="https://yinlingchaoliu:${{secrets.ACCESS_TOKEN}}@$push_addr"
  git remote add origin $access_url
  git push origin HEAD:$push_branch --force # 推送到github $deploy_branch分支
fi

cd -
rm -rf $dist_path