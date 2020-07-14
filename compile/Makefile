include make.options

# Fortran compiler and its options are set in make.options

ALL=uvic
all: $(ALL)

LIBS=common/libcommon.a embm/libembm.a ice/libice.a ism/libism.a\
	mom/libmom.a mtlm/libmtlm.a netcdf/libncdf.a rot/librot.a sed/libsed.a


#common/libcommon.a: $(OBJS)

uvic: $(LIBS)
	$(FC) -o uvic -lnetcdff -L/cm/shared/local/netcdf-intel/lib */*.a */*.a
#	$(FC) -o uvic_gnu $(FFLAGS) -lnetcdff -lnetcdf -L/ptardat2/ashao/local/gaggle/gnu/netcdf/lib */*.a */*.a

common/libcommon.a:
	echo "make common"
	cd common; make libcommon.a; cd ..

embm/libembm.a:
	cd embm; make libembm.a; cd ..

ice/libice.a:
	cd ice; make libice.a; cd ..

ism/libism.a:
	cd ism; make libism.a; cd ..

mom/libmom.a: mom/adv_vel.F  mom/calc_psgrad.F    mom/convect.F  \
	 mom/diago.F   mom/hmixc.F   mom/loadmw.F    mom/mom_tbt.F   \
	mom/poisson.F  mom/setmom.F   mom/state.F           mom/tracer.F\
	mom/bardiv.F   mom/checks.F         mom/delsq.F     mom/energy.F  \
	mom/hyper3.F  mom/matrix.F    mom/mom_tsi.F   mom/ppmix.F    \
	mom/set_sbc.F  mom/tbt.F             mom/tropic.F\
	mom/bcest.F    mom/clinic.F         mom/denscoef.F  mom/fdifm.F   \
	mom/invtri.F  mom/mom.F       mom/neptune.F   mom/reg1st.F   \
	mom/setvbc.F   mom/termbal.F         mom/vmixc.F\
	mom/bhf.F      mom/congrad.F        mom/diag.F      mom/fdift.F   \
	mom/io.F      mom/mom_rest.F  mom/npzd_src.F  mom/relax1.F   \
	mom/smagnl.F   mom/timeavgs.F        mom/xbt.F\
	mom/blmixi.F   mom/convect_brine.F  mom/diagi.F     mom/gyre.F    \
	mom/isopyc.F  mom/mom_tavg.F  mom/odam.F      mom/setkmp.F   \
	mom/stab.F     mom/tracer_adv_flx.F\
	mom/cshort.h  mom/ctavg.h  mom/ctmb.h  mom/diaga.h  \
	mom/docnam.h  mom/matrix.h  mom/mw.h  \
	mom/state.h  mom/tbt.h  mom/tidal_kv.h  mom/timeavgs.h  mom/xbt.h
	cd mom; make libmom.a; cd ..

mtlm/libmtlm.a:
	cd mtlm; make libmtlm.a; cd ..

netcdf/libncdf.a: 
	cd netcdf; make libncdf.a; cd ..

rot/librot.a:
	cd rot; make librot.a; cd ..

sed/libsed.a:
	cd sed; make libsed.a; cd ..



install: all
	mv -f $(ALL) $(HOME)/bin

clean:
	rm -f $(ALL)
	cd common; make clean; cd ..
	cd embm; make clean; cd ..
	cd ice; make clean; cd ..
	cd ism; make clean; cd ..
	cd mom; make clean; cd ..
	cd mtlm; make clean; cd ..
	cd netcdf; make clean; cd ..
	cd rot; make clean; cd ..
	cd sed; make clean; cd ..


clobber:
	rm -f $(ALL)
	cd common; make clobber; cd ..
	cd embm; make clobber; cd ..
	cd ice; make clobber; cd ..
	cd ism; make clobber; cd ..
	cd mom; make clobber; cd ..
	cd mtlm; make clobber; cd ..
	cd netcdf; make clobber; cd ..
	cd rot; make clobber; cd ..
	cd sed; make clobber; cd ..


