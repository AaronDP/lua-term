#this file builds lua-term \o/
NDK_USR_PATH 	:= $(NDK)
LUA_VER         ?= 5.1
LUA_DIR         ?= /data/local/tmp/lib
LUA_LIBDIR      := $(LUA_DIR)/lua/$(LUA_VER)/term
LUA_INC         := $(LUA_DIR)/lua
LUA_SHARE       := $(LUA_DIR)/lua/$(LUA_VER)/term
CWARNS          := -Wall -pedantic
CFLAGS          += $(CWARNS) -O3 -I$(LUA_INC) 
CFLAGS          += -fPIC -Bdynamic -Wl,--gc-section -Wl,-z,nocopyreloc -Wl,--no-undefined 
CFLAGS          += -Wl,--dynamic-linker=/system/bin/linker -Wl,-rpath-link=$(NDK_USR_PATH)/lib 
CFLAGS          += -nostdlib $(NDK_USR_PATH)/lib/crtend_android.o $(NDK_USR_PATH)/lib/crtbegin_dynamic.o 
CFLAGS          += -L$(NDK_USR_PATH)/lib
LIB_OPTION      := -shared

SONAME          := core.so
SONAMEV         := $(SONAME).1
LIBRARY         := $(SONAMEV).0.1
SRC             := core.c
OBJ             := $(patsubst %.c, %.o, $(SRC))

FILES           := term/init.lua term/cursor.lua term/colors.lua

all: $(LIBRARY) $(SONAMEV) $(SONAME)

$(SONAMEV):
	ln -s $(LIBRARY) $@

$(SONAME):
	ln -s $(SONAMEV) $@

$(LIBRARY): $(OBJ)
	$(CC) $(CFLAGS) $(LIB_OPTION) -o $(LIBRARY) $(OBJ) -lc

install:
	mkdir -p $(LUA_LIBDIR)
	cp $(SONAME) $(LUA_LIBDIR)
	mkdir -p $(LUA_SHARE)
	cp $(FILES) $(LUA_SHARE)

clean:
	$(RM) $(LIBRARY) $(SONAMEV) $(SONAME) *.o
