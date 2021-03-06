

// Setup file for the MEGA prototype in the Duke configuration

Name MEGAPrototype_Duke_v3.0
Version 3.0

SurroundingSphere 200  0.0  0.0  20.0  200.0



// Include section

// NEEDS THIS LINE TO VIEW ALONE:
// Include Materials.geo


// World volume section

// Volume WorldVolume             
// WorldVolume.Material Air
// WorldVolume.Visibility 0
// WorldVolume.Shape BRIK 1000. 1000. 1000.
// WorldVolume.Mother 0

Volume 2cm_CsICore
2cm_CsICore.Material Air
2cm_CsICore.Visibility 2
//2cm_CsICore.Virtual true  // not really necessary because volume fits!
2cm_CsICore.Shape BRIK 2.885 3.455 1.
// NEEDS THIS LINE TO VIEW ALONE:
// 2cm_CsICore.Mother 0



// Basic Volume Types:

// CsI Crystal Cell:
Volume 2cm_CsICrystal
2cm_CsICrystal.Material CsI
2cm_CsICrystal.Visibility 1
2cm_CsICrystal.Color 4
2cm_CsICrystal.Shape BRIK 0.25 0.25 1.0

// CsI Crystal Block of 10 cells:
Volume 2cm_CsICrystalBlock
2cm_CsICrystalBlock.Material Millipore
2cm_CsICrystalBlock.Visibility 1
2cm_CsICrystalBlock.Shape BRIK 2.885 0.285 1.
2cm_CsICrystalBlock.Color 3


// Millipore Layer:
Volume 2cm_MilliPoreLayer
2cm_MilliPoreLayer.Material Millipore
2cm_MilliPoreLayer.Visibility 1 
2cm_MilliPoreLayer.Color 3
2cm_MilliPoreLayer.Shape BRIK 2.885 0.0175 1.0




// define a CsI Crystal Volume row consisting of 10 CsI cells:

2cm_CsICrystal.Copy 2cm_CsICrystalN04
2cm_CsICrystalN04.Position 0.285 0. 0.
2cm_CsICrystalN04.Mother 2cm_CsICrystalBlock

2cm_CsICrystal.Copy 2cm_CsICrystalN03
2cm_CsICrystalN03.Position 0.855  0. 0.
2cm_CsICrystalN03.Mother 2cm_CsICrystalBlock

2cm_CsICrystal.Copy 2cm_CsICrystalN02
2cm_CsICrystalN02.Position 1.425  0. 0.
2cm_CsICrystalN02.Mother 2cm_CsICrystalBlock

2cm_CsICrystal.Copy 2cm_CsICrystalN01
2cm_CsICrystalN01.Position 1.995  0. 0.
2cm_CsICrystalN01.Mother 2cm_CsICrystalBlock

2cm_CsICrystal.Copy 2cm_CsICrystalN00
2cm_CsICrystalN00.Position 2.565  0. 0.
2cm_CsICrystalN00.Mother 2cm_CsICrystalBlock

2cm_CsICrystal.Copy 2cm_CsICrystalN05
2cm_CsICrystalN05.Position -0.285 0. 0.
2cm_CsICrystalN05.Mother 2cm_CsICrystalBlock

2cm_CsICrystal.Copy 2cm_CsICrystalN06
2cm_CsICrystalN06.Position -0.855  0. 0.
2cm_CsICrystalN06.Mother 2cm_CsICrystalBlock

2cm_CsICrystal.Copy 2cm_CsICrystalN07
2cm_CsICrystalN07.Position -1.425  0. 0.
2cm_CsICrystalN07.Mother 2cm_CsICrystalBlock

2cm_CsICrystal.Copy 2cm_CsICrystalN08
2cm_CsICrystalN08.Position -1.995  0. 0.
2cm_CsICrystalN08.Mother 2cm_CsICrystalBlock

2cm_CsICrystal.Copy 2cm_CsICrystalN09
2cm_CsICrystalN09.Position -2.565  0. 0.
2cm_CsICrystalN09.Mother 2cm_CsICrystalBlock


// 10 rows:

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN0
2cm_CsICrystalBlockN0.Position 0. 0.285 0.
2cm_CsICrystalBlockN0.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN1
2cm_CsICrystalBlockN1.Position 0. -0.285 0.
2cm_CsICrystalBlockN1.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN2
2cm_CsICrystalBlockN2.Position 0. 0.855 0.
2cm_CsICrystalBlockN2.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN3
2cm_CsICrystalBlockN3.Position 0. -0.855 0.
2cm_CsICrystalBlockN3.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN4
2cm_CsICrystalBlockN4.Position 0. 1.425 0.
2cm_CsICrystalBlockN4.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN5
2cm_CsICrystalBlockN5.Position 0. -1.425 0.
2cm_CsICrystalBlockN5.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN6
2cm_CsICrystalBlockN6.Position 0. 1.995 0.
2cm_CsICrystalBlockN6.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN7
2cm_CsICrystalBlockN7.Position 0. -1.995 0.
2cm_CsICrystalBlockN7.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN8
2cm_CsICrystalBlockN8.Position 0. 2.565 0.
2cm_CsICrystalBlockN8.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN9
2cm_CsICrystalBlockN9.Position 0. -2.565 0.
2cm_CsICrystalBlockN9.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN10
2cm_CsICrystalBlockN10.Position 0. 3.135 0.
2cm_CsICrystalBlockN10.Mother 2cm_CsICore

2cm_CsICrystalBlock.Copy 2cm_CsICrystalBlockN11
2cm_CsICrystalBlockN11.Position 0. -3.135 0.
2cm_CsICrystalBlockN11.Mother 2cm_CsICore

// plus two layers of millipore on each end of the rows:

2cm_MilliPoreLayer.Copy 2cm_MilliPoreLayerA
2cm_MilliPoreLayerA.Position 0. -3.4375 0.
2cm_MilliPoreLayerA.Mother 2cm_CsICore

2cm_MilliPoreLayer.Copy 2cm_MilliPoreLayerB
2cm_MilliPoreLayerB.Position 0. 3.4375 0.
2cm_MilliPoreLayerB.Mother 2cm_CsICore



