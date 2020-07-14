include ../make.options

.SUFFIXES: .o .f .F

SRCS = uvic_netcdf.f

OBJS = $(SRCS:.f=.o)
LIB = libncdf.a

all: $(LIB)

$(OBJS): %.o: %.f
	$(FC) -c $(FFLAGS) $*.f -o $*.o

all: $(LIB)

libncdf.a: $(OBJS)
	ar r $(LIB) $(OBJS)

clean:
	/bin/rm -f *.o *.a

clobber: clean

