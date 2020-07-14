include ../make.options
CPPFLAGS2 = -traditional -P -I../common -I../embm
CPP = /lib/cpp 

.SUFFIXES: .o .f .F .FF

SRCS = adv_vel.F  bhf.F blmixi.F       clinic.F         convect.F   diag.F\
     energy.F  hyper3.F  isopyc.F  mom.F       mom_tbt.F  npzd_src.F\
     ppmix.F   setkmp.F  smagnl.F  tbt.F       tracer_adv_flx.F  vmixc.F\
     bardiv.F   calc_psgrad.F  congrad.F        delsq.F     diagi.F  gyre.F\
     invtri.F  loadmw.F  mom_rest.F  mom_tsi.F  odam.F      reg1st.F\
     setmom.F  stab.F    termbal.F   tracer.F          xbt.F\
     bcest.F    checks.F       convect_brine.F  denscoef.F  diago.F\
     hmixc.F   io.F      matrix.F  mom_tavg.F  neptune.F  poisson.F\
     relax1.F  set_sbc.F setvbc.F  state.F   timeavgs.F  tropic.F\
     fdifm.F   fdift.F

FFSRCS = $(SRCS:.F=.FF)
RCS = $(FFSRCS:.FF=.f)
OBJS = $(RCS:.f=.o)
LIB = libmom.a

all: $(LIB)

$(FFSRCS): %.FF: %.F
	$(HOME)/perl/modify_include.pl $*.F

$(RCS): %.f: %.FF
	$(CPP) $(CPPFLAGS) $(CPPFLAGS2) $*.FF > $*.f

$(OBJS): %.o: %.f
	$(FC) -c $(FFLAGS) $*.f -o $*.o

libmom.a: $(OBJS)
	ar r $(LIB) $(OBJS)

clean:
	/bin/rm -f *.o *.a

clobber: clean
	/bin/rm -f *.f *.FF

