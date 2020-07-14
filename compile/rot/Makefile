include ../make.options


.SUFFIXES: .o .f .F

SRCS = uvic_rot.f

OBJS = $(SRCS:.f=.o)
LIB = librot.a

$(OBJS): %.o: %.f
	$(FC) -c $(FFLAGS) $*.f -o $*.o

all: $(LIB)

librot.a: $(OBJS)
	ar r $(LIB) $(OBJS)

clean:
	/bin/rm -f *.o *.a

clobber: clean
