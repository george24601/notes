<<INTRO
sysbench is a scriptable multi-threaded benchmark tool based on LuaJIT. It is most frequently used for database benchmarks, but can also be used to create arbitrarily complex workloads that do not involve a database server.

oltp_*.lua: a collection of OLTP-like database benchmarks

low overhead even with thousands of concurrent threads. sysbench is capable of generating and tracking hundreds of millions of events per second;

can be used as a general-purpose Lua interpreter as well, simply replace #!/usr/bin/lua with #!/usr/bin/sysbench in your script.
INTRO

#Install
git clone https://github.com/akopytov/sysbench.git
yum -y install make automake libtool pkgconfig libaio-devel vim-common
yum -y install mariadb-devel

#Build and Install
./autogen.sh
./configure
make
make install

./sysbench ./lua/oltp_read_only.lua \
	--mysql-host=127.0.0.1 --mysql-port=4000 --mysql-user=root --mysql-password="" \
	--mysql-db=test --tables=16 --table-size=1000000 \
	--report-interval=10 \
	--threads=256 --time=120 \
	prepare

	#prepare/run/cleanup

#prepare
