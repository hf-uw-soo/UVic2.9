      module memory_window
!     Variable declarations moved from mw.h for use in OpenMP loops

      implicit none
      save
      
!     this is where imt etc. parameters are defined:
      include "size.h"

      real :: adv_vnt(imt,km,1:jmw)
#if defined O_fct
!      real :: adv_fn(imt,km,1:jemw)
#endif
!      real :: t(imt,km,jmw,nt,-1:1)

      end module memory_window
