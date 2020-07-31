      module isopyc
!     Variable declarations moved from isopyc.h for use in OpenMP loops

      implicit none
      save

!     this is where imt etc. parameters are defined:
      include "size.h"

      real :: adv_vetiso(imt,km,jsmw:jemw)
      real :: adv_vntiso(imt,km,1:jemw)
      real :: adv_vbtiso(imt,0:km,jsmw:jemw)

      end module isopyc
