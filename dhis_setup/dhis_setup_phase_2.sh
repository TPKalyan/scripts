createuser -SDRP dhis
createdb -O dhis dhis2

echo '
max_connections = 200
shared_buffers = 3200MB
work_mem = 20MB
maintenance_work_mem = 512MB
effective_cache_size = 8000MB
checkpoint_completion_target = 0.8
synchronous_commit = off
wal_writer_delay = 10000ms
' >> /etc/postgresql/9.5/main/postgresql.conf

psql -c "create extension postgis;" dhis2

exit
