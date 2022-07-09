TARGET=kayac-app-1

build:
	go build -o app

deploy: build
	ssh $(TARGET) pkill app || true
	scp app $(TARGET):/var/www/isucon/webapp/golang/app
