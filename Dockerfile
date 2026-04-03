FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tigervnc-standalone-server novnc websockify openbox x11-xserver-utils fonts-wqy-zenhei fonts-noto-cjk curl gnupg ca-certificates dbus-x11 --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && apt-get update && apt-get install -y google-chrome-stable && rm -rf /var/lib/apt/lists/*
RUN ln -sf /usr/share/novnc/vnc.html /usr/share/novnc/index.html && mkdir -p /root/.config/openbox
COPY autostart /root/.config/openbox/autostart
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]

