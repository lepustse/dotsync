#!/bin/bash
#!/bin/zsh

session=$1

# 兼容zsh
export DISABLE_AUTO_TITLE="true"

# 判断是否存在 $session 会话
tmux has-session -t $session
if [ $? = 0 ];then
    tmux attach-session -t $session
    exit
fi

# 创建一个新session名称为 $session，新窗口名为bash，并detach
tmux new-session -d -s $session -n debug
tmux split-window -h -p 65 # 竖直分割
tmux split-window -v -p 30 # 水平分割
tmux select-pane -t 3
tmux split-window -h -p 180
# 将窗口分为上下两部分

## 竖直分割
#tmux split-window -h
#tmux select-pane -t 1
#tmux split-window -v
## 将窗口分为上下两部分，并通过-p指定比例
#tmux split-window -v -p 40

# 创建一个新的窗口
tmux new-window -t $select:2

# 这个暂时先不要了
#tmux new-window -t $session:3 -n

# 选择一个默认窗口
#tmux send-keys -t $session:1 'top' C-m
tmux select-window -t $session:1
tmux select-pane -t 3 #	选择哪个pane
#tmux send-keys -t $session:1 'top' C-m 先不开
tmux select-pane -t 1 # 选择pane1
tmux attach-session -t $session
