#CXXFLAGS+=-O2 -Wall -D_FILE_OFFSET_BITS=64 -D USE_UTF16
CXXFLAGS+=-O2 -Wall -D_FILE_OFFSET_BITS=64
LDFLAGS+=
LDLIBS+=-luuid #-licuio -licuuc
LIB_NAMES=crc32 support guid gptpart mbrpart basicmbr mbr gpt bsd parttypes attributes diskio diskio-unix
MBR_LIBS=support diskio diskio-unix basicmbr mbrpart
LIB_OBJS=$(LIB_NAMES:=.o)
MBR_LIB_OBJS=$(MBR_LIBS:=.o)
LIB_HEADERS=$(LIB_NAMES:=.h)
DEPEND= makedepend $(CXXFLAGS)

all:	cgdisk gdisk sgdisk fixparts

gdisk:	$(LIB_OBJS) gdisk.o gpttext.o
	$(CXX) $(LIB_OBJS) gdisk.o gpttext.o $(LDFLAGS) $(LDLIBS) -o gdisk

cgdisk: $(LIB_OBJS) cgdisk.o gptcurses.o
	$(CXX) $(LIB_OBJS) cgdisk.o gptcurses.o $(LDFLAGS) $(LDLIBS) -lncursesw -o cgdisk

sgdisk: $(LIB_OBJS) sgdisk.o gptcl.o
	$(CXX) $(LIB_OBJS) sgdisk.o gptcl.o $(LDFLAGS) $(LDLIBS) -lpopt -o sgdisk

fixparts: $(MBR_LIB_OBJS) fixparts.o
	$(CXX) $(MBR_LIB_OBJS) fixparts.o $(LDFLAGS) -o fixparts

test:
	./gdisk_test.sh

lint:	#no pre-reqs
	lint $(SRCS)

clean:	#no pre-reqs
	rm -f core *.o *~ gdisk sgdisk cgdisk fixparts

# what are the source dependencies
depend: $(SRCS)
	$(DEPEND) $(SRCS)

$(OBJS):
	$(CRITICAL_CXX_FLAGS) 

# makedepend dependencies below -- type "makedepend *.cc" to regenerate....
# DO NOT DELETE
