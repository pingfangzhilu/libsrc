#TARGET_ARCH=x86
TARGET_ARCH=mips463

ifeq ($(TARGET_ARCH), mips342)
CROSS_COMPILE	=/opt/buildroot-gcc342/bin/mipsel-linux-
TAR = libbase342.so
else ifeq ($(TARGET_ARCH), mips463)
CROSS_COMPILE   =/opt/buildroot-gcc463/usr/bin/mipsel-linux-
TAR = libbase463.so
else ifeq ($(TARGET_ARCH), x86)
TAR=libbase.so
endif

CC=$(CROSS_COMPILE)gcc

STRIP=$(CROSS_COMPILE)strip	
CC=$(CROSS_COMPILE)gcc

CFLAGS = -Wall -fPIC -shared 


all +=net/tcpsrv/sock_fd.o
all +=net/tcpsrv/getwanip.o
all +=net/tcpsrv/NetWork.o
all +=net/udp/udp_sock.o

all +=pool/que_mempool.o
all +=pool/pthread_pool.o
all +=aes128/aes_demo.o
all +=file/fileMes.o

all +=worklist/queWorkCond.o

all +=cjson/cJSON.o

all +=voices/mp3head.o

all +=tools/InputCmd.o
all +=tools/serial.o

ifeq ($(TARGET_ARCH), x86)
all +=tools/gbk_uf8.o
endif
INC +=pool/pool.h
INC +=aes128/aes_demo.h
INC +=net/tcpsrv/demo_tcp.h
INC +=net/udp/udp_sock.h
INC +=file/fileMes.h
INC +=cjson/cJSON.h
INC +=voices/head_mp3.h
INC +=worklist/queWorkCond.h
INC +=tools/tools.h

export CC
$(TAR): $(all)
	@echo "sss" 
	$(CC) $(CFLAGS) $(all) -o $(TAR) -lpthread -lm
#	$(STRIP)  $(TAR) 
	cp $(INC) output/
	cp $(TAR) output/
	chmod 777 output/*
	$(RM) -f *.gch *.bak $(all) 
	
%.o:%.c
	$(CC) $(CFLAGS) -c -o $@ $< 

.PHONY: clean
clean:
	rm -f $(TAR) $(all) 
