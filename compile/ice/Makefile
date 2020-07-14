include ../make.options
CPPFLAGS2 = -traditional -P -I../common -I../embm
CPP = /lib/cpp 

.SUFFIXES: .o .f .F .FF

LIB = libice.a
all: $(LIB)

SRCS = cpts.F  evp.F  iceadv.F  ice.F  therm.F

FFSRCS = $(SRCS:.F=.FF)
RCS = $(FFSRCS:.FF=.f)
OBJS = $(RCS:.f=.o)

$(FFSRCS): %.FF: %.F
	$(HOME)/perl/modify_include.pl $*.F

$(RCS): %.f: %.FF
	$(CPP) $(CPPFLAGS) $(CPPFLAGS2) $*.FF > $*.f

$(OBJS): %.o: %.f
	$(FC) -c $(FFLAGS) $*.f -o $*.o


libice.a: $(OBJS)
	ar r $(LIB) $(OBJS)

clean:
	/bin/rm -f *.o *.a

clobber: clean
	/bin/rm -f *.f *.FF

