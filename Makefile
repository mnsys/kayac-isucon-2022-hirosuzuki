TARGET=kayac-app-1
HOST1=kayac-app-1
HOST2=kayac-app-2
HOST3=kayac-app-3
TIMEID := $(shell date +%Y%m%d-%H%M%S)

build:
	go build -o app

deploy: build
	ssh $(TARGET) sudo tee /etc/nginx/nginx.conf >/dev/null <nginx.conf
	ssh $(TARGET) sudo nginx -t
	ssh $(TARGET) sudo systemctl restart nginx
	ssh $(TARGET) pkill app || true
	scp app $(TARGET):/var/www/isucon/webapp/golang/app
	scp start.sh $(TARGET):/var/www/isucon/webapp/golang/start.sh
	ssh $(HOST1) sudo truncate -c -s 0 /var/log/nginx/access.log
	ssh $(HOST1) sudo truncate -c -s 0 /tmp/sql.log

perf-logs-viewer:
		# go install https://github.com/hirosuzuki/perf-logs-viewer:latest
		perf-logs-viewer

pprof:
		go tool pprof -http="127.0.0.1:8081" logs/latest/cpu-web1.pprof

collect-logs:
		mkdir -p logs/$(TIMEID)
		rm -f logs/latest
		ln -sf $(TIMEID) logs/latest
		scp $(HOST1):/tmp/cpu.pprof logs/latest/cpu-web1.pprof
		ssh $(HOST1) sudo chmod 644 /var/log/nginx/access.log
		scp $(HOST1):/var/log/nginx/access.log logs/latest/access-web1.log
		scp $(HOST1):/tmp/sql.log logs/latest/sql-web1.log
		ssh $(HOST1) sudo truncate -c -s 0 /var/log/nginx/access.log
		ssh $(HOST1) sudo truncate -c -s 0 /tmp/sql.log

truncate-logs:
		ssh $(HOST1) sudo truncate -c -s 0 /var/log/nginx/access.log
		ssh $(HOST1) sudo truncate -c -s 0 /tmp/sql.log
