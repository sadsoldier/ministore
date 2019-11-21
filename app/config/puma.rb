environment 'production'

daemonize false

directory '/home/ziggi/ministore/app'
rackup 'config.ru'
pidfile '/home/ziggi/ministore/app/run/puma.pid'
state_path '/home/ziggi/ministore/app/run/puma.state'
stdout_redirect '/home/ziggi/ministore/app/log/puma.stdout',
	'/home/ziggi/ministore/app/log/puma.stderr', true
threads 1, 16
bind 'tcp://127.0.0.1:8089'
workers 3


