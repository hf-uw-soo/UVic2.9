include ../make.options

.SUFFIXES: .o .f .F

SRCS = ism.F  ismio.F  ism_rest.F  ism_tavg.F  ism_tsi.F  setism.F

OBJS = $(SRCS:.F=.o)
LIB = libism.a

$(OBJS): %.o: %.F
	$(FC) -c $(FFLAGS) $*.F -o $*.o

all: $(LIB)

libism.a: $(OBJS)
	ar r $(LIB) $(OBJS)

clean:
	/bin/rm -f *.o *.a

clobber: clean
	/bin/rm -f *.f

