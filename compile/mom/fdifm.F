! replacement functions for statement functions that used to be defined in fdifm.h

!     finite difference numerics for momentum
!=======================================================================

!-----------------------------------------------------------------------
!     advective terms
!-----------------------------------------------------------------------

      real function ADV_Ux(i, k, j)
#if !defined O_linearized_advection
      use memory_window, only: adv_fe
#endif
      implicit none
      integer, intent(in) :: i, k, j
      include "size.h"
      include "mw.h"

#if defined O_linearized_advection
      ADV_Ux = 0.0
#else
      ADV_Ux = (adv_fe(i,k,j) - adv_fe(i-1,k,j))*csudxu2r(i,j)
#endif      

      end


      real function ADV_Uy(i, k, j, jrow, n)
      implicit none
      integer, intent(in) :: i, k, j, jrow, n
      include "size.h"
      include "mw.h"
      include "grdvar.h"

#if defined O_linearized_advection
      ADV_Uy = 0.0
#else
      ADV_Uy = (adv_vnu(i,k,j)*(u(i,k,j,n,tau)
     &  + u(i,k,j+1,n,tau)) - adv_vnu(i,k,j-1)*(u(i,k,j-1,n,tau)
     &  + u(i,k,j,n,tau)))*csudyu2r(jrow)
#endif
      
      end


      real function ADV_Uz(i, k, j)
#if !defined O_linearized_advection
      use memory_window, only: adv_fb
#endif
      implicit none
      integer, intent(in) :: i, k, j
      include "size.h"
      include "mw.h"
      include "grdvar.h"

#if defined O_linearized_advection
      ADV_Uz = 0.0
#else
      ADV_Uz = (adv_fb(i,k-1,j) - adv_fb(i,k,j))*dzt2r(k)
#endif

      end


      real function ADV_metric(i, k, j, jrow, n)
      implicit none
      integer, intent(in) :: i, k, j, jrow, n
      include "size.h"
      include "mw.h"

#if defined O_linearized_advection
      ADV_metric = 0.0
#else
      ADV_metric = advmet(jrow,n)*u(i,k,j,1,tau)
     &  *u(i,k,j,3-n,tau)
#endif

      end

!-----------------------------------------------------------------------
!     diffusive terms
!-----------------------------------------------------------------------

      real function DIFF_Ux(i, k, j)
      implicit none
      integer, intent(in) :: i, k, j
      include "size.h"
      include "mw.h"

      DIFF_Ux = (diff_fe(i,k,j) - diff_fe(i-1,k,j))
     &  *csudxur(i,j)

      end


      real function DIFF_Uy(i, k, j, jrow, n)
      implicit none
      integer, intent(in) :: i, k, j, jrow, n
      include "size.h"
      include "mw.h"
      include "hmixc.h"
      include "cnep.h"
      include "grdvar.h"

#if defined O_consthmix && !defined O_biharmonic
# if defined O_neptune
      DIFF_Uy = amc_north(jrow)*(u(i,k,j+1,n,taum1)
     &  - u(i,k,j,n,taum1) - unep(i,jrow+1,n)*umask(i,k,j+1)
     $  + unep(i,jrow,n)*umask(i,k,j)) - amc_south(jrow)
     &  *(u(i,k,j,n,taum1) - u(i,k,j-1,n,taum1) - unep(i,jrow,n)
     $  *umask(i,k,j) + unep(i,jrow-1,n)*umask(i,k,j-1))
# else
#  if defined O_anisotropic_viscosity
      DIFF_Uy = amc_north(i,k,jrow)*(u(i,k,j+1,n,taum1)
     &  - u(i,k,j,n,taum1)) - amc_south(i,k,jrow)*(u(i,k,j,n,taum1)
     &  - u(i,k,j-1,n,taum1))
#  else
      DIFF_Uy = amc_north(jrow)*(u(i,k,j+1,n,taum1)
     &  - u(i,k,j,n,taum1)) - amc_south(jrow)*(u(i,k,j,n,taum1)
     &  - u(i,k,j-1,n,taum1))
#  endif
# endif
#else
      DIFF_Uy = (diff_fn(i,k,j) - diff_fn(i,k,j-1))
     &  *csudyur(jrow)
#endif

      end


      real function DIFF_Uz(i, k, j)
      implicit none
      integer, intent(in) :: i, k, j
      include "size.h"
      include "mw.h"
      include "grdvar.h"

      DIFF_Uz = (diff_fb(i,k-1,j) - diff_fb(i,k,j))*dztr(k)
#if defined O_implicitvmix
     &  *(c1-aidif)
#endif

      end


!-----------------------------------------------------------------------
!     metric term
!-----------------------------------------------------------------------
      real function DIFF_metric(i, k, j, jrow, n)
      implicit none
      integer, intent(in) :: i, k, j, jrow, n
      include "size.h"
      include "mw.h"
      include "hmixc.h"
      include "grdvar.h"
      include "cnep.h"

#if defined O_consthmix
# if defined O_biharmonic
      DIFF_metric = am3(jrow)*del2(i,k,j,n) + am4(jrow,n)
     &  *(del2(i+1,k,j,3-n) - del2(i-1,k,j,3-n))*dxmetr(i)
# else
#  if defined O_neptune
      DIFF_metric = am3(jrow)*(u(i,k,j,n,taum1)
     $  - unep(i,jrow,n)*umask(i,k,j)) + am4(jrow,n)*dxmetr(i)
     &  *(u(i+1,k,j,3-n,taum1) - u(i-1,k,j,3-n,taum1)
     $  - unep(i+1,jrow,3-n)*umask(i+1,k,j) + unep(i-1,jrow,3-n)
     $  *umask(i-1,k,j))
#  else
      DIFF_metric = am3(jrow)*u(i,k,j,n,taum1)
     &  + am4(jrow,n)*dxmetr(i)*(u(i+1,k,j,3-n,taum1)
     &  - u(i-1,k,j,3-n,taum1))
#  endif
# endif
#else
# if defined O_smagnlmix
      DIFF_metric = smag_metric(i,k,j)
# endif
#endif

      end



!-----------------------------------------------------------------------
!     coriolis term
!-----------------------------------------------------------------------
      real function CORIOLIS(i, k, j, jrow, n)
      implicit none
      integer, intent(in) :: i, k, j, jrow, n
      include "size.h"
      include "mw.h"
      include "scalar.h"

#if defined O_stream_function
# if defined O_damp_inertial_oscillation
      CORIOLIS = (c1-acor)*cori(i,jrow,n)
     &  *u(i,k,j,3-n,taum1)
# else
      CORIOLIS = cori(i,jrow,n)*u(i,k,j,3-n,tau)
# endif
#else
      CORIOLIS = cori(i,jrow,n)*(gcor*u(i,k,j,3-n,tau)
     &  + (c1-gcor)*u(i,k,j,3-n,taum1))
#endif
      
      end
