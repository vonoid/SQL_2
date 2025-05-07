#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Страница с рисунком</title></head><body><h1>IMAGE in HTML</h1><img src="http://nikolai-2025.05.07.storage.yandexcloud.net/deadline-timeline.png"></body></html>" | sudo tee /var/www/html/index.html