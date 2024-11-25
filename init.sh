#!/bin/bash

# 스크립트 실행 중 에러 발생 시 중단
set -e

# 현재 디렉토리 경로 가져오기
CURRENT_DIR=$(pwd)

# C 프로그램 파일 절대 경로
C_FILE="$CURRENT_DIR/shutdown_on_packet.c"

# 컴파일 후 실행 파일 경로
EXECUTABLE="/usr/local/bin/shutdown_on_packet"

# systemd 서비스 파일 경로
SERVICE_FILE="/etc/systemd/system/shutdown_on_packet.service"

# 1. C 파일 존재 여부 확인
if [[ ! -f "$C_FILE" ]]; then
    echo "Error: $C_FILE not found!"
    exit 1
fi

# 2. C 파일 컴파일
echo "Compiling $C_FILE..."
gcc "$C_FILE" -o "$EXECUTABLE"

# 3. 실행 파일에 실행 권한 부여
echo "Setting executable permissions..."
chmod +x "$EXECUTABLE"

# 4. systemd 서비스 파일 생성
echo "Creating systemd service file..."
cat <<EOL | sudo tee "$SERVICE_FILE"
[Unit]
Description=Shutdown on Packet Service
After=network.target

[Service]
ExecStart=$EXECUTABLE
Restart=on-failure
User=root

[Install]
WantedBy=multi-user.target
EOL

# 5. systemd 서비스 등록 및 활성화
echo "Enabling and starting the service..."
sudo systemctl daemon-reload
sudo systemctl enable shutdown_on_packet.service
sudo systemctl start shutdown_on_packet.service

# 6. 완료 메시지
echo "Setup complete! The service is now active and will start on boot."