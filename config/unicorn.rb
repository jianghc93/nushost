listen "127.0.0.1:8080"
worker_processes 4
working_directory "/home/rails/current"
pid "/var/run/unicorn.pid"
stderr_path "/var/log/unicorn/unicorn.log"
stdout_path "/var/log/unicorn/unicorn.log"