// For disabling the discrete GPU

DefinitionBlock("", "SSDT", 2, "hack", "AMD", 0)
{   
    External(_SB.PCI0, DeviceObj)
    Scope(_SB.PCI0)
    {
        Device(RMD1)
        {
            Name(_HID, "RMD10000")
            Method(_INI)
            {
                // disable discrete graphics (Nvidia) if it is present
               If (CondRefOf(\_SB.PCI0.RP05.PEGP._OFF)) { \_SB.PCI0.RP05.PEGP._OFF() }
            }
        }
        
        External(RP05.PEGP, DeviceObj)
        Scope(RP05.PEGP)
        {
            External(\P8XH, MethodObj)
            External(LCTL, FieldUnitObj)
            External(ELCT, IntObj)
            External(\_SB.PCI0.RP05.LNKD, FieldUnitObj)
            External(\_SB.PCI0.RP05.LNKS, FieldUnitObj)
            External(SGPO, MethodObj)
            External(HLRS, FieldUnitObj)
            External(PWEN, FieldUnitObj)
            External(SVID, FieldUnitObj)
            External(HVID, BuffObj)
            External(SDID, FieldUnitObj)
            External(HDID, BuffObj)
            
            Method (_OFF, 0, Serialized) // disable nVidia from method _OFF
            { 
                P8XH (Zero, 0xD7, One)
                Debug = "_SB.PCI0.RP05.PEGP._OFF"

                ELCT = LCTL
                HVID = SVID
                HDID = SDID
                LNKD = One
                While (LNKS != Zero)
                {
                    Sleep (One)
                }

                SGPO (HLRS, One)
                Sleep (0x02)
                SGPO (PWEN, Zero)
                Sleep (0x14)
                Notify (\_SB.PCI0.RP05, Zero)
                Return (Zero)
            }
        }

        External(LPCB.EC0, DeviceObj)
        Scope(LPCB.EC0)
        {
            External(\ECON, FieldUnitObj)
            External(XREG, MethodObj)
            External(GATY, FieldUnitObj)
            
            Method (_REG, 2, NotSerialized) // disable nVidia from method _REG
            {
                \_SB.PCI0.LPCB.EC0.XREG(Arg0, Arg1)
                If (ECON) { \_SB.PCI0.LPCB.EC0.GATY = Zero }
            }
        }      
        
        
    }
}
//EOF