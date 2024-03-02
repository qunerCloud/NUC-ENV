echo "gmaster ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers \
&& sudo mv /etc/apt/sources.list /etc/apt/sources.list.old \
&& sudo touch /etc/apt/sources.list \
&& echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list \
&& echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list \
&& echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list \
&& echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list \
&& sudo apt update \
&& sudo apt upgrade -y \
&& sudo apt install -y locales \
&& sudo locale-gen en_US en_US.UTF-8 \
&& sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
&& export LANG=en_US.UTF-8 \
&& sudo apt install software-properties-common \
&& sudo add-apt-repository universe \
&& sudo apt update \
&& sudo apt install git -y \
&& sudo apt install curl -y \
&& sudo curl -sSL https://r.qunercloud.com/https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] https://mirrors.tuna.tsinghua.edu.cn/ros2/ubuntu/ $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null \
&& sudo apt update && sudo apt install -y python3-pip ros-dev-tools 2> /dev/null \
&& sudo apt update && sudo apt install -y ros-foxy-desktop ros-foxy-xacro "ros-foxy-rqt*" "ros-foxy-ros2-control*" python3-rosdep 2> /dev/null \
&& sudo apt install -y libsocketcan-dev ninja-build libserial-dev 2> /dev/null \
&& sudo apt update && sudo apt install -y can-utils minicom network-manager 2> /dev/null \
&& sudo apt install -y openssh-server \
&& sudo systemctl start ssh \
&& sudo systemctl enable ssh \
&& sudo mkdir -p ~/.ssh \
&& echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6sRG3S5TjslzH225UY82Ny4H6ruGFiZT5ul6zIGnzhCR0RrqhV6+Su99UjpWnpt8xw6mBo8dIYAcpJKgk1DeuB7gj3RHL1dIIuE+7epZ7Zq3RxPzyXDHMByF95ta5noA17qIQNabSrAuwJe/AUV26A2W2RHQBtWdsv1xrNBIc1BJqNGtxzeN9IzzS7Kj/jWh0n36Ddy2WGcExewWV+7CPvZDwA44EcuXuV1PID7cDIPd3v3CHxveUBeK/6DBn0QEfZardDhdiMmW6NLyKYFPbc91QYNVERWs6xM18CDHv0EaVNywzKa7uSJAW1WRUgPD2+K/wRTsZAbUGCJ3A8W8VYjQYwlFpjcdqGBCSThCUfDBKwVVfET6LvsuTHfSVV4pi83N/RDhlab1peSDYrint6lcOSwLf6mS9XJ4U3FM1jdPeCdkhJWMVUyM0zR1EQ3UJs9Avl3utzD5nBW/NDe5xSx4qwcIueumqge2BJwthIN4xyLurKkrzgACn1WJEwrk= qunercloud@qunerWinX" >> ~/.ssh/authorized_keys \
&& sudo chmod 600 ~/.ssh/authorized_keys \
&& sudo chmod 700 ~/.ssh \
&& cd /home/gmaster \
&& sudo apt install unzip -y \
&& sudo apt-get install python3 python3-setuptools -y || true \
&& sudo apt-get install libffi-dev -y || true \
&& sudo apt-get install python3-pip -y || true \
&& pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
&& pip3 install numpy || true \
&& sudo nmcli dev wifi list \
&& sudo nmcli dev wifi connect 'GMaster-NUC' password '' hidden yes \
&& sudo apt install expect -y \
&& sudo apt-get install libcairo2-dev -y
