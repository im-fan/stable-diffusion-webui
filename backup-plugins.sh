#shell获取文件夹下主文件夹名和github项目链接
# shell: echo $(basename $(dirname $(readlink -f $0)))
# github: https://github.com/DominikDoom/a1111-sd-webui-tagcomplete
#!/bin/bash

# 指定文件夹路径
FOLDER_PATH="./extensions"

# 获取文件夹下所有主文件夹的名称
FOLDERS=$(ls -d $FOLDER_PATH/*/)

# 声明变量,存放多个项目名+github项目链接
# 获取当前时间 格式 yyyy-MM-dd HH:mm:ss
NOW=$(date +"%Y-%m-%d %H:%M:%S")
PROJECTS="\nSD插件备份-[$NOW]"

# 遍历每个主文件夹
for FOLDER in $FOLDERS; do
    # 获取主文件夹名称
    FOLDER_NAME=$(basename $FOLDER)

    # 切换到主文件夹目录
    cd $FOLDER

    # 获取与当前主文件夹关联的远程仓库的 URL
    REMOTE_URL=$(git remote -v | grep origin | grep fetch | awk '{print $2}')

    # 输出主文件夹名称和对应的 GitHub 项目链接
    echo "主文件夹名称: $FOLDER_NAME"
    echo "GitHub 项目链接: $REMOTE_URL"
    echo

    #文本添加换行
    PROJECTS="$PROJECTS \n $FOLDER_NAME: $REMOTE_URL"
    # 切回到原来的工作目录
    cd -
done

# 将PROJECTS追加写入backup-plugin.txt文件头部
echo "$PROJECTS\n$(cat backup-plugin.txt)" > backup-plugin.txt

