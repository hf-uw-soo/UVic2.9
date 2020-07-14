include ../make.options
CPPFLAGS2 = -traditional -P -I../common -I../embm -I../mom
CPP = /lib/cpp 

.SUFFIXES: .o .f .F .FF

SRCS = sed.F  sediment.F  sedio.F  sed_rest.F  sed_tavg.F  sed_tsi.F  setsed.F

FFSRCS = $(SRCS:.F=.FF)
RCS = $(FFSRCS:.FF=.f)
OBJS = $(RCS:.f=.o)
LIB = libsed.a

$(FFSRCS): %.FF: %.F
	$(HOME)/perl/modify_include.pl $*.F

$(RCS): %.f: %.FF
	$(CPP) $(CPPFLAGS) $(CPPFLAGS2) $*.FF > $*.f

$(OBJS): %.o: %.f
	$(FC) -c $(FFLAGS) $*.f -o $*.o

all: $(LIB)

libsed.a: $(OBJS)
	ar r $(LIB) $(OBJS)

clean:
	/bin/rm -f *.o *.a

clobber: clean
	/bin/rm -f *.f *.FF

