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
        
        External(\P8XH, MethodObj)
        External(RP05.PEGP.LCTL, FieldUnitObj)
        External(RP05.PEGP.ELCT, IntObj)
        External(RP05.PEGP.LNKD, FieldUnitObj)
        External(RP05.PEGP.LNKS, FieldUnitObj)
        External(RP05.PEGP.SGPO, MethodObj)
        External(RP05.PEGP.HLRS, FieldUnitObj)
        External(RP05.PEGP.PWEN, FieldUnitObj)
        External(RP05.PEGP.SVID, FieldUnitObj)
        External(RP05.PEGP.HVID, BuffObj)
        External(RP05.PEGP.SDID, FieldUnitObj)
        External(RP05.PEGP.HDID, BuffObj)
        Method (RP05.PEGP._OFF, 0, Serialized) // disable nVidia from method _OFF
        { 
            P8XH (Zero, 0xD7, One)
            Store ("_SB.PCI0.RP05.PEGP._OFF", Debug)

            Store (LCTL, ELCT)
            Store (SVID, HVID)
            Store (SDID, HDID)
            Store (One, LNKD)
            While (LNotEqual (LNKS, Zero))
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
        
        External(LPCB.EC0.XREG, MethodObj)
        External(LPCB.EC0.GATY, FieldUnitObj)
        External(\ECON, FieldUnitObj)
        Method (LPCB.EC0._REG, 2, NotSerialized) // disable nVidia from method _REG
        {
            \_SB.PCI0.LPCB.EC0.XREG(Arg0, Arg1)
            If (ECON) { Store (Zero, \_SB.PCI0.LPCB.EC0.GATY) }
        }
    }
}
//EOF
