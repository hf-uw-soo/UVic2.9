include ../make.options
# Preprocessor and its options
CPPFLAGS2 = -traditional -P -I../common -I../embm -I ../mom
CPP = /lib/cpp 

ALL=libcommon.a
all: $(ALL)

#libcommon.a: aggdata.o c14data.o cfcdata.o co2calc.o co2data.o co2distdata.o\
#	data.o def_files.o file_names.o filfir.o filt.o filtr.o filuv.o\
#	findex.o gasbc.o global_sums.o gosbc.o grids.o icedata.o iomngr.o\
#	isleperim.o reg1st.o sealevdata.o setcom.o setdata.o size_check.o\
#	solardata.o sulphdata.o switch.o timeinterp.o tmngr.o topog.o\
#	util.o UVic_ESCM.o volcdata.o

SRCS =  aggdata.F c14data.F cfcdata.F co2calc.F co2data.F co2distdata.F\
	data.F def_files.F file_names.F filfir.F filt.F filtr.F filuv.F\
	findex.F gasbc.F global_sums.F gosbc.F grids.F icedata.F iomngr.F\
	isleperim.F reg1st.F sealevdata.F setcom.F setdata.F size_check.F\
	solardata.F sulphdata.F switch.F timeinterp.F tmngr.F topog.F\
	util.F UVic_ESCM.F volcdata.F


FFSRCS = $(SRCS:.F=.FF)
RCS = $(FFSRCS:.FF=.f)
OBJS = $(RCS:.f=.o)
LIB = libcommon.a

libcommon.a: $(OBJS)
	ar r $(LIB) $(OBJS)

# standard types
SUFFIXES: .f .o .F .FF

$(FFSRCS): %.FF: %.F
	$(HOME)/perl/modify_include.pl $*.F

$(RCS): %.f: %.FF
	$(CPP) $(CPPFLAGS) $(CPPFLAGS2) $*.FF > $*.f

$(OBJS): %.o: %.f
	$(FC) -c $(FFLAGS) $*.f -o $*.o


install: all
	mv -f $(ALL) $(HOME)/bin


clean:
	rm -f *.o *.a core

clobber: clean
	rm -f *.FF *.f

