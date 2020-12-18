#!/bin/bash

LCG=/cvmfs/sft.cern.ch/lcg/views/LCG_96python3/x86_64-centos7-gcc8-opt
source ${LCG}/setup.sh
python -m venv dask_venv
source dask_venv/bin/activate

export PYTHONPATH=""
export PATH=${PWD}/dask_venv/bin:${PATH}

pypackages=lib/python3.6/site-packages/
lcgprefix=${LCG}/${pypackages}

ln -sf ${lcgprefix}/pyxrootd dask_venv/${pypackages}/pyxrootd
ln -sf ${lcgprefix}/XRootD dask_venv/${pypackages}/XRootD

pip install --upgrade pip wheel --no-cache-dir
pip install dask[dataframe] distributed coffea[dask]==0.6.47 --no-cache-dir
pip list

echo "Dask worker environment created at ${PWD}/dask_venv"

/bin/pwd
/bin/uname -a
/bin/hostname

echo $@

$@


