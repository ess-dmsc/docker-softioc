TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = SimpleIoc
# SimpleIoc.dbd will be created and installed
DBD += SimpleIoc.dbd

# SimpleIoc.dbd will be made up from these files:
SimpleIoc_DBD += base.dbd

# Include dbd files from all support applications:
#SimpleIoc_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#SimpleIoc_LIBS += xxx

# SimpleIoc_registerRecordDeviceDriver.cpp derives from SimpleIoc.dbd
SimpleIoc_SRCS += SimpleIoc_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
SimpleIoc_SRCS_DEFAULT += SimpleIocMain.cpp
SimpleIoc_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#SimpleIoc_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
SimpleIoc_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

