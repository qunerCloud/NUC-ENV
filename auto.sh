echo "gmaster ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers \
&& sudo mv /etc/apt/sources.list /etc/apt/sources.list.old \
&& sudo touch /etc/apt/sources.list \
&& echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list \
&& echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list \
&& echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list \
&& echo 'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list \
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
&& sudo apt update && sudo apt install -y ros-humble-desktop ros-humble-xacro "ros-humble-rqt*" "ros-humble-ros2-control*" python3-rosdep 2> /dev/null \
&& sudo apt install -y libsocketcan-dev ninja-build libserial-dev 2> /dev/null \
&& sudo apt update && sudo apt install -y can-utils minicom network-manager 2> /dev/null \
&& sudo apt install -y openssh-server \
&& sudo systemctl start ssh \
&& sudo systemctl enable ssh \
&& sudo mkdir -p ~/.ssh \
&& echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6sRG3S5TjslzH225UY82Ny4H6ruGFiZT5ul6zIGnzhCR0RrqhV6+Su99UjpWnpt8xw6mBo8dIYAcpJKgk1DeuB7gj3RHL1dIIuE+7epZ7Zq3RxPzyXDHMByF95ta5noA17qIQNabSrAuwJe/AUV26A2W2RHQBtWdsv1xrNBIc1BJqNGtxzeN9IzzS7Kj/jWh0n36Ddy2WGcExewWV+7CPvZDwA44EcuXuV1PID7cDIPd3v3CHxveUBeK/6DBn0QEfZardDhdiMmW6NLyKYFPbc91QYNVERWs6xM18CDHv0EaVNywzKa7uSJAW1WRUgPD2+K/wRTsZAbUGCJ3A8W8VYjQYwlFpjcdqGBCSThCUfDBKwVVfET6LvsuTHfSVV4pi83N/RDhlab1peSDYrint6lcOSwLf6mS9XJ4U3FM1jdPeCdkhJWMVUyM0zR1EQ3UJs9Avl3utzD5nBW/NDe5xSx4qwcIueumqge2BJwthIN4xyLurKkrzgACn1WJEwrk= qunercloud@qunerWinX" >> ~/.ssh/authorized_keys \
&& sudo chmod 600 ~/.ssh/authorized_keys \
&& sudo chmod 700 ~/.ssh \
&& cd /tmp \
&& sudo wget http://10.0.2.254/SDK/Galaxy_camera.run \
&& sudo wget http://10.0.2.254/SDK/Galaxy_Linux_Python_2.0.2106.9041.zip \
&& sudo chmod +x Galaxy_camera.run \
&& echo -e "Y\nEn" | sudo ./Galaxy_camera.run \
&& sudo apt install unzip -y \
&& unzip Galaxy_Linux_Python_2.0.2106.9041.zip \
&& sudo apt-get install python3 python3-setuptools -y || true \
&& sudo apt-get install libffi-dev -y || true \
&& cd Galaxy_Linux_Python_2.0.2106.9041/api \
&& sudo python3 setup.py build \
&& sudo python3 setup.py install \
&& sudo apt-get install python3-pip -y || true \
&& pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
&& pip3 install numpy || true \
&& sudo nmcli dev wifi list \
&& sudo nmcli dev wifi connect 'GMaster-NUC' password '' hidden yes \
&& sudo apt install expect -y \
&& sudo apt-get install libcairo2-dev -y \
&& cd /tmp \
&& sudo wget https://raw.githubusercontent.com/qunerCloud/NUC-ENV/main/OneClickDesktop.sh \
&& sudo chmod +x OneClickDesktop.sh \
&& sudo su \
&& sudo apt install nginx openssl -y \
&& sudo mkdir -p /etc/nginx/ssl \
&& sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/nginx/ssl/selfsigned.key -out /etc/nginx/ssl/selfsigned.crt -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=control.qunercloud.com" \
&& echo -e "server {\n listen 443 ssl;\n server_name _;\n ssl_certificate /etc/nginx/ssl/selfsigned.crt;\n ssl_certificate_key /etc/nginx/ssl/selfsigned.key;\n location / {\n proxy_pass http://localhost:8080;\n proxy_http_version 1.1;\n proxy_set_header Upgrade \$http_upgrade;\n proxy_set_header Connection 'upgrade';\n proxy_set_header Host \$host;\n proxy_cache_bypass \$http_upgrade;\n }\n location /guacamole/ {\n proxy_pass http://localhost:8080/guacamole/;\n proxy_http_version 1.1;\n proxy_set_header Upgrade \$http_upgrade;\n proxy_set_header Connection 'upgrade';\n proxy_set_header Host \$host;\n proxy_cache_bypass \$http_upgrade;\n }\n}\n server {\n listen 80;\n server_name _;\n return 301 https://\$host/guacamole/\$request_uri;\n}" | sudo tee /etc/nginx/sites-available/default \
&& sudo nginx -t \
&& sudo systemctl restart nginx \
&& sudo systemctl enable nginx

