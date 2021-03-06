#!/bin/bash

# What to simulate
Materials="Germanium Silicon"
Energies="10000 1000 100"
Triggers="1000000"


commandhelp() {
  echo ""
  echo "run --- run a unit test";
  echo "Copyright by Andreas Zoglauer"
  echo ""
  echo "Usage: ./run [options]";
  echo ""
  echo "Options:"
  echo "  --simulate=[yes/no]: Perform simulations (default: yes)"
  echo "  --analyze=[yes/no]: Perform the analysis and create the histograms (default: yes)"
  echo "  --compare=[yes/no]: Perform the visual comparision (default: yes)"
  echo "  --help: Show this help."
  echo ""
}


# Store command line as array
CMD=( "$@" )

# Check for help
for C in "${CMD[@]}"; do
  if [[ ${C} == *-h* ]]; then
    echo ""
    commandhelp
    exit 0
  fi
done


# Default options:
SIM="y"
ANA="y"
CMP="y"


# Overwrite default options with user options:
for C in "${CMD[@]}"; do
  if [[ ${C} == *-s*=* ]]; then
    SIM=`echo ${C} | awk -F"=" '{ print $2 }'`
  elif [[ ${C} == *-a*=* ]]; then
    ANA=`echo ${C} | awk -F"=" '{ print $2 }'`
  elif [[ ${C} == *-c*=* ]]; then
    CMP=`echo ${C} | awk -F"=" '{ print $2 }'`
  elif [[ ${C} == *-h* ]]; then
    echo ""
    commandhelp
    exit 0
  else
    echo ""
    echo "ERROR: Unknown command line option: ${C}"
    echo "       See \"./run --help\" for a list of options"
    exit 1
  fi
done


# Everything to lower case:
SIM=`echo ${SIM} | tr '[:upper:]' '[:lower:]'`
ANA=`echo ${ANA} | tr '[:upper:]' '[:lower:]'`
CMP=`echo ${CMP} | tr '[:upper:]' '[:lower:]'`


# Provide feed back and perform error checks:
echo ""
echo "Chosen options:"

if [[ ${SIM} == y* ]]; then
  SIM="y"
  echo " * Performing simulations"
elif [[ ${SIM} == n* ]]; then
  SIM="n"
  echo " * Performing no simulations"
else
  echo " "
  echo "ERROR: Unknown simulation instructions: ${SIM}"
  commandhelp
  exit 1
fi

if [[ ${ANA} == y* ]]; then
  ANA="y"
  echo " * Performing analysis"
elif [[ ${ANA} == n* ]]; then
  ANA="n"
  echo " * Performing no analysis"
else
  echo " "
  echo "ERROR: Unknown analysis instructions: ${ANA}"
  commandhelp
  exit 1
fi

if [[ ${CMP} == y* ]]; then
  CMP="y"
  echo " * Performing comparison"
elif [[ ${CMP} == n* ]]; then
  CMP="n"
  echo " * Performing no comparison"
else
  echo " "
  echo "ERROR: Unknown comparison instructions: ${CMP}"
  commandhelp
  exit 1
fi



# Maximum number of cores to use
Cores=`nproc`

# Megalib version ID
MegalibVersion=`cat ${MEGALIB}/config/Version.txt  | sed 's|\.||g'`

# ROOT version ID
if [ -f ${ROOTSYS}/bin/root-config ]; then
  rv=`${ROOTSYS}/bin/root-config --version`
  version=`echo $rv | awk -F. '{ print $1 }'`;
  release=`echo $rv | awk -F/ '{ print $1 }' | awk -F. '{ print $2 }'| sed 's/0*//'`;
  patch=`echo $rv | awk -F/ '{ print $2 }'| sed 's/0*//'`;
  RootVersion=$((10000*${version} + 100*${release} + ${patch}))
else
  echo " "
  echo "ERROR: No correct ROOT installation found"
  exit 1;
fi

# Geant4 version ID
if [ -f ${G4LIB}/../../bin/geant4-config ]; then
  Geant4Version=`${G4LIB}/../../bin/geant4-config --version | sed 's|\.||g'`
else
  echo " "
  echo "ERROR: No correct Geant4 installation found"
  exit 1;
fi

# The version tag
Tag=m${MegalibVersion}.r${RootVersion}.g${Geant4Version} 

# Create a new temporary setup file
for M in ${Materials}; do
  Geometry="Temp.Shells.${M}.geo.setup"
  sed -e "s|Constant MAT Germanium|Constant MAT ${M}|g" < Shells.geo.setup > ${Geometry}
done


# Simulation loop
if [ "${SIM}" == "y" ]; then
  for M in ${Materials}; do
    #continue;
    Geometry="Temp.Shells.${M}.geo.setup"
    for E in ${Energies}; do
      # Remove existing sim files
      Sim="ShellsSim.${M}.${E}keV.${Tag}"
      rm -f ${Sim}.*.sim
  
      # Create a new temporary source file
      Source="Temp.Shells.${M}.${E}keV.source"
      sed -e "s|Geometry Shells.geo.setup|Geometry ${Geometry}|g" -e "s|ShellsSim.FileName ShellsSim|ShellsSim.FileName ${Sim}|g" -e "s|ShellsSource.Spectrum Mono 1000|ShellsSource.Spectrum Mono ${E}|g" -e "s|ShellsSim.Triggers 100000|ShellsSim.Triggers ${Triggers}|g" < Shells.source > ${Source}
    
      # Start the simulation
      mdelay cosima ${Cores}
      cosima -v 0 ${Source} > /dev/null &
      sleep 2
    done
  done

  # Wait until all simulations are done
  mdelay cosima 0
fi


# Analysis loop
if [ "${ANA}" == "y" ]; then
  for M in ${Materials}; do
    ########continue
    # Create a new temporary setup file
    Geometry="Temp.Shells.${M}.geo.setup"
    for E in ${Energies}; do
      # Create the output files
      Sim="ShellsSim.${M}.${E}keV.${Tag}.inc1.id1.sim"
      PostFix="${M}.${E}keV.${Tag}"
      Shells -f ${Sim} -g ${Geometry} -o ${PostFix} > /dev/null
    done
  done
fi


# Now compare with historic versions
if [ "${CMP}" == "y" ]; then
  Histograms="EnergyDepositRange LocationFirstComptonIA LocationFirstPhotoIA LocationFirstPairIA FirstComptonDeposit NumberComptonIAs NumberPhotoIAs NumberPairIAs NumberRayleighIAs" 
  for M in ${Materials}; do
    for E in ${Energies}; do
      PostFix="${M}.${E}keV"
      for H in ${Histograms}; do
        Files=`ls Historic/${H}.${PostFix}.*.root`
        Simulation="${H}.${M}.${E}keV.${Tag}.root"
        for F in ${Files}; do
          ID=${F##Historic/${H}.${PostFix}.}
          ID=${ID%%.root}
          echo "Comparing histogram ${H} for material ${M} and energy ${E} keV with histogram created with ${ID}:"
          Output="${H}.${M}.${E}keV..comp..${Tag}..vs..${ID}.root"
          CompareHistograms -m ${F} -s ${Simulation} -o ${Output} -b
          if [ "$?" != "0" ]; then
            ShowHistograms -f ${Output} > /dev/null
          fi
          echo " " 
        done
      done
    done
  done
fi

exit 0







