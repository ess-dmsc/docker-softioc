#!../../bin/darwin-x86/SimpleIoc

#- You may have to change SimpleIoc to something else
#- everywhere it appears in this file

#< envPaths

## Register all support components
dbLoadDatabase("../../dbd/SimpleIoc.dbd",0,0)
SimpleIoc_registerRecordDeviceDriver(pdbbase) 

## Load record instances
dbLoadRecords("../../db/simple.db","P=SIMPLE:")

iocInit()
