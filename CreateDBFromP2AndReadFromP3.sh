#!/bin/sh

rm -rf venvP2
rm -rf venvP3
rm -rf venvM2to3
rm -rf Data_python2.*

virtualenv venvP3
virtualenv venvP2 -p python2
virtualenv venvM2to3 -p python2

venvP3/bin/pip install ZODB
venvP2/bin/pip install ZODB
venvM2to3/bin/pip install zodb.py3migrate

echo "Youhou l’environnement est prêt"
echo "*******************************"
echo "On crée la DB en python2"
venvP2/bin/python createDBandputP2unicodetype.py

echo "*******************************"
echo "On dégage l’index, le lock et le tmp"
rm ./Data_python2.fs.index
rm ./Data_python2.fs.tmp
rm ./Data_python2.fs.lock

echo "*******************************"
echo "On analyse la DB"
venvM2to3/bin/zodb-py3migrate-analyze ./Data_python2.fs

echo "*******************************"
echo "On modifie le magic byte"
venvM2to3/bin/zodb-py3migrate-magic ./Data_python2.fs Python3

echo "*******************************"
echo "On dégage l’index, le lock et le tmp"
rm ./Data_python2.fs.index
rm ./Data_python2.fs.tmp
rm ./Data_python2.fs.lock

echo "*******************************"
echo "On tente de relire"
venvP3/bin/python readDbfrompython3.py

