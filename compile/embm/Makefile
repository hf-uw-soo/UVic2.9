include ../make.options
CPPFLAGS2 = -traditional -P -I../common -I../embm -I../ice
CPP = /lib/cpp 

.SUFFIXES: .o .f .F .FF

SRCS =adi.F  embmbc.F  embm.F  embmio.F  embm_rest.F  embm_tavg.F\
	embm_tsi.F  fluxes.F  gvsbc.F  insolation.F  mgrid.F  rivmodel.F\
	setembm.F  slap.F  solve.F  winds.F 

FFSRCS = $(SRCS:.F=.FF)
RCS = $(FFSRCS:.FF=.f)
OBJS = $(RCS:.f=.o)
LIB = libembm.a

$(FFSRCS): %.FF: %.F
	$(HOME)/perl/modify_include.pl $*.F

$(RCS): %.f: %.FF
	$(CPP) $(CPPFLAGS) $(CPPFLAGS2) $*.FF > $*.f

$(OBJS): %.o: %.f
	$(FC) -c $(FFLAGS) $*.f -o $*.o

all: $(LIB)

libembm.a: $(OBJS)
	ar r $(LIB) $(OBJS)

clean:
	/bin/rm -f *.o *.a

clobber: clean
	/bin/rm -f *.f *.FF

