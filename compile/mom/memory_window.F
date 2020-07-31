      module memory_window
!     Variable declarations moved from mw.h for use in OpenMP loops

      implicit none
      save
      
!     this is where imt etc. parameters are defined:
      include "size.h"

      real :: adv_vbt(imt,0:km,jsmw:jmw)
      real :: adv_vet(imt,km,jsmw:jmw)
      real :: adv_vnt(imt,km,1:jmw)
      real :: adv_fb(imt,0:km,jsmw:jemw)
      real :: adv_fe(imt,km,jsmw:jemw)
#if defined O_fct
      real :: adv_fn(imt,km,1:jemw)
#endif
      real :: t(imt,km,jmw,nt,-1:1)

      end module memory_window
