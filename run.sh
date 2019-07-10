#!/bin/sh

set -eu

gen_cp=false
cp_conf="target/cp.conf"

if [ "$(uname -o)" = Cygwin ]; then
  sep=";"
else
  sep=":"
fi

if [ "${1:-}" = "--classpath" ]; then
  gen_cp=true
  shift
elif [ ! -f "$cp_conf" ]; then
  gen_cp=true
fi

if $gen_cp; then
  ( set -x; mvn -Dmdep.outputFile="$cp_conf" dependency:build-classpath )
fi

now="$(date +%Y%m%d_%H%M%S)"
log_dir="logs"
log_name="smallpt-${now}.log"
log_link="smallpt.log"
mkdir -p "$log_dir"
touch "$log_dir/$log_name"
rm -f "$log_dir/$log_link"
( cd "$log_dir"; ln -s "$log_name" "$log_link" )

{
  echo "[$JAVA_HOME]"
  time java -cp "target/classes$sep$(< "$cp_conf")" naoki.smallpt.SmallPT
} 2>&1 | tee "$log_dir/$log_name"
