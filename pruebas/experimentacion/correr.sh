#!/bin/bash
set -e
cd "$(dirname "$0")"

correr() {
  nombre=$1
  shift
  rm -rf "reporte_$nombre" "$nombre.jtl"
  jmeter -n -t Experimentacion.jmx "$@" -l "$nombre.jtl" -e -o "reporte_$nombre"
}

curl -sf http://127.0.0.1:8080/api/salud > /dev/null

correr p2_subida1 -Jhilos=200 -Jsubida=1
correr p2_subida60 -Jhilos=200 -Jsubida=60

correr p3_con_timer -Jhilos=200 -Jsubida=60
correr p3_sin_timer -Jhilos=200 -Jsubida=60 -Jretardo=0 -Jrango=0

correr p4_50 -Jhilos=50 -Jsubida=30
correr p4_100 -Jhilos=100 -Jsubida=30
correr p4_250 -Jhilos=250 -Jsubida=30
correr p4_500 -Jhilos=500 -Jsubida=30

correr p5_1min -Jhilos=50 -Jsubida=10 -Jbucles=-1 -Jduracion=60
correr p5_10min -Jhilos=50 -Jsubida=10 -Jbucles=-1 -Jduracion=600