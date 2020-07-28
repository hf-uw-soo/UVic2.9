! replacement functions for statement functions that used to be defined in fdift.h

!-----------------------------------------------------------------------
!     advective terms
!-----------------------------------------------------------------------

      real function ADV_Tx(i, k, j)
      implicit none
      integer, intent(in) :: i, k, j
      include "size.h"
      include "mw.h"

#if defined O_linearized_advection
      ADV_Tx = 0.0
#else
      ADV_Tx = (adv_fe(i,k,j) - adv_fe(i-1,k,j))*cstdxt2r(i,j)
#endif
      end

      real function ADV_Ty(i, k, j, jrow, n)
      use memory_window, only: adv_vnt
      implicit none
      integer, intent(in) :: i, k, j, jrow, n
      include "size.h"
      include "mw.h"
      include "grdvar.h"

#if defined O_linearized_advection
      ADV_Ty = 0.0
#else
# if defined O_fourth_order_tracer_advection || defined O_quicker
      ADV_Ty = (adv_f4n(i,k,j,n) - adv_f4n(i,k,j-1,n))
     &  *cstdyt2r(jrow)
# else
#  if defined O_fct
      ADV_Ty = (adv_fn(i,k,j) - adv_fn(i,k,j-1))
     &  *cstdyt2r(jrow)
#  else
      ADV_Ty = (adv_vnt(i,k,j)*(t(i,k,j,n,tau)
     &  + t(i,k,j+1,n,tau)) - adv_vnt(i,k,j-1)*(t(i,k,j-1,n,tau)
     &  + t(i,k,j,n,tau)))*cstdyt2r(jrow)
#  endif
# endif
#endif
      end


      real function ADV_Tz(i, k, j)
      implicit none
      integer, intent(in) :: i, k, j
      include "size.h"
      include "mw.h"
      include "grdvar.h"

#if defined O_linearized_advection
      ADV_Tz = (adv_fb(i,k-1,j) - adv_fb(i,k,j))*dzt2r(k)
#else
      ADV_Tz = (adv_fb(i,k-1,j) - adv_fb(i,k,j))*dzt2r(k)
#endif
      end


#if defined O_gent_mcwilliams && defined O_isopycmix
!     gent_mcwilliams isopycnal advective terms simulating the effect
!     of eddies on the isopycnals
      real function ADV_Txiso(i, k, j, n)
      implicit none
      integer, intent(in) :: i, k, j, n
      include "size.h"
      include "mw.h"
      include "isopyc.h"

      ADV_Txiso = cstdxt2r(i,j)*(adv_vetiso(i,k,j)
     &  *(t(i+1,k,j,n,taum1) + t(i,k,j,n,taum1)) - adv_vetiso(i-1,k,j)
     &  *(t(i,k,j,n,taum1) + t(i-1,k,j,n,taum1)))

      end


      real function ADV_Tyiso(i, k, j, jrow, n)
      implicit none
      integer, intent(in) :: i, k, j, jrow, n
      include "size.h"
      include "mw.h"
      include "grdvar.h"
      include "isopyc.h"

      ADV_Tyiso = cstdyt2r(jrow)*(adv_vntiso(i,k,j)
     &  *(t(i,k,j+1,n,taum1) + t(i,k,j,n,taum1)) - adv_vntiso(i,k,j-1)
     &  *(t(i,k,j,n,taum1) + t(i,k,j-1,n,taum1)))

      end


      real function ADV_Tziso(i, k, j)
      implicit none
      integer, intent(in) :: i, k, j
      include "size.h"
      include "grdvar.h"
      include "isopyc.h"

      ADV_Tziso = dzt2r(k)*(adv_fbiso(i,k-1,j)-adv_fbiso(i,k,j))
      
      end
#endif

!-----------------------------------------------------------------------
!     diffusive terms
!-----------------------------------------------------------------------

!     zonal component
      real function DIFF_Tx(i, k, j)
      implicit none
      integer, intent(in) :: i, k, j
      include "size.h"
      include "mw.h"

      DIFF_Tx = (diff_fe(i,  k,j)*tmask(i+1,k,j)
     &  - diff_fe(i-1,k,j)*tmask(i-1,k,j))*cstdxtr(i,j)

      end


!     meridional component
      real function DIFF_Ty(i, k, j, jrow, n)
      implicit none
      integer, intent(in) :: i, k, j, jrow, n
      include "size.h"
      include "mw.h"
      include "grdvar.h"

#if defined O_consthmix && !defined O_biharmonic && !defined O_isopycmix
# if defined O_bryan_lewis_horizontal
      DIFF_Ty = ahc_north(jrow,k)*tmask(i,k,j+1)
     &  *(t(i,k,j+1,n,taum1) - t(i,k,j,n,taum1)) - ahc_south(jrow,k)
     &  *tmask(i,k,j-1)*(t(i,k,j,n,taum1) - t(i,k,j-1,n,taum1))
# else
      DIFF_Ty = ahc_north(jrow)*tmask(i,k,j+1)
     &  *(t(i,k,j+1,n,taum1) - t(i,k,j,n,taum1)) - ahc_south(jrow)
     &  *tmask(i,k,j-1)*(t(i,k,j,n,taum1) - t(i,k,j-1,n,taum1))
# endif
#else
      DIFF_Ty = (diff_fn(i,k,j  )*tmask(i,k,j+1)
     &  - diff_fn(i,k,j-1)*tmask(i,k,j-1))*cstdytr(jrow)
#endif

      end


!     vertical component
      real function DIFF_Tz(i, k, j)
      implicit none
      integer, intent(in) :: i, k, j
      include "size.h"
      include "mw.h"
      include "grdvar.h"
      include "vmixc.h"
      include "pconst.h"

      DIFF_Tz = (diff_fb(i,k-1,j) - diff_fb(i,k,j))*dztr(k)
#if defined O_implicitvmix || defined O_isopycmix || defined O_redi_diffusion
     &  *(c1-aidif)
#endif
#if defined O_isopycmix
     &  + (diff_fbiso(i,k-1,j) - diff_fbiso(i,k,j))*dztr(k)
#endif

      end
