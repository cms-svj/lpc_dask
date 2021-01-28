#!/bin/bash

LCG=/cvmfs/sft.cern.ch/lcg/views/LCG_96python3/x86_64-centos7-gcc8-opt
source ${LCG}/setup.sh
VENV=dask_venv
python -m venv ${VENV}
source ${VENV}/bin/activate

export PYTHONPATH=""
export PATH=${PWD}/${VENV}/bin:${PATH}

pypackages=lib/python3.6/site-packages/
lcgprefix=${LCG}/${pypackages}

ln -sf ${lcgprefix}/pyxrootd ${VENV}/${pypackages}/pyxrootd
ln -sf ${lcgprefix}/XRootD ${VENV}/${pypackages}/XRootD

pip install --upgrade pip wheel --no-cache-dir
pip install dask[dataframe]==2020.12.0 distributed==2020.12.0 coffea[dask]==0.6.47 --no-cache-dir
pip list

echo "Dask worker environment created at ${PWD}/${VENV}"

if [ -f patch.sh ]; then
	./patch.sh ${VENV}
fi

/bin/pwd
/bin/uname -a
/bin/hostname

echo $@

$@


