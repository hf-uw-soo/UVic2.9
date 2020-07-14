include ../make.options
CPPFLAGS2 = -traditional -P -I../common -I../embm
CPP = /lib/cpp 

.SUFFIXES: .o .f .F .FF

SRCS = canopy.F  leaf_lit.F  microbe.F  mtlmio.F     mtlm_state.F\
	mtlm_tsi.F  pft_sparm.F  qsat.F     sf_stom.F   swrad.F\
	vegcarb.F glsbc.F   lotka.F     mtlm.F     mtlm_rest.F\
	mtlm_tavg.F   penmon.F    phenol.F  setmtlm.F  soilcarb.F  triffid.F

FFSRCS = $(SRCS:.F=.FF)
RCS = $(FFSRCS:.FF=.f)
OBJS = $(RCS:.f=.o)
LIB = libmtlm.a

libmtlm.a: $(OBJS)
	ar r $(LIB) $(OBJS)
all: $(LIB)

$(FFSRCS): %.FF: %.F
	$(HOME)/perl/modify_include.pl $*.F

$(RCS): %.f: %.FF
	$(CPP) $(CPPFLAGS) $(CPPFLAGS2) $*.FF > $*.f

$(OBJS): %.o: %.f
	$(FC) -c $(FFLAGS) $*.f -o $*.o


clean:
	/bin/rm -f *.o *.a

clobber: clean
	/bin/rm -f *.f *.FF

