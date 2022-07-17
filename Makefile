# project name
TARGET_SERVER=server
TARGET_CLIENT=client

# user way install
PRF_USERWAY=/usr/local/bin

# project compiler
CC=clang++

# cpp standart version
DEFINES=-std=c++17

# project flags release
CXXRFLAGS= $(DEFINES) -O2 -fPIC -march=native

# project flags debug
CXXFLAGS= $(DEFINES) -Wall -Werror -Wextra -Wpedantic -fPIC -march=native -g

# directory with source code server
PRF_SRC_SERVER=./src/server/
PRF_SRC_CLIENT=./src/client/

# directory with object files
PRF_OBJ_SERVER=./obj/server/
PRF_OBJ_CLIENT=./obj/client/

# libs
LDLIBS=-lfmt
LIBINCLUDE=/usr/lib64/libfmt.so

# list source files
SERVER_SRC=$(wildcard $(PRF_SRC_SERVER)*.cpp)
CLIENT_SRC=$(wildcard $(PRF_SRC_CLIENT)*.cpp)
SERVER_OBJ=$(patsubst $(PRF_SRC_SERVER)%.cpp, $(PRF_OBJ_SERVER)%.o, $(SERVER_SRC))
CLIENT_OBJ=$(patsubst $(PRF_SRC_CLIENT)%.cpp, $(PRF_OBJ_CLIENT)%.o, $(CLIENT_SRC))

# all targets
.PHONY : all release server client debug clear install uninstall docs

# default make
all : server client

# Make server
server : $(SERVER_OBJ)
	$(CC) $(CXXRFLAGS) $(SERVER_OBJ) $(LIBINCLUDE) $(LDLIBS) -o $(TARGET_SERVER)

# Make client
client : $(CLIENT_OBJ)
	$(CC) $(CXXRFLAGS) $(CLIENT_OBJ) $(LIBINCLUDE) $(LDLIBS) -o $(TARGET_CLIENT)

# generate .o files
$(PRF_OBJ_SERVER)%.o : $(PRF_SRC_SERVER)%.cpp 
	$(CC) -c $(CXXFLAGS) $< -o $@

$(PRF_OBJ_CLIENT)%.o : $(PRF_SRC_CLIENT)%.cpp
	$(CC) -c $(CXXFLAGS) $< -o $@

# clean object and binary files
clean :
	rm -rf $(PRF_OBJ)*.o $(TARGET_SERVER) $(TARGET_CLIENT) doc/*
