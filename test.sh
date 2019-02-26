ex1=`curl -v http://localhost:6666/mod_cluster_manager | grep CONTEXT | grep examples1 | awk ' { print $10 } ' | sed 's:=: :g' | sed 's:": :g' | sed 's:&: :g' | awk ' { print $9 } '`
echo $ex1
ex2=`curl -v http://localhost:6666/mod_cluster_manager | grep CONTEXT | grep examples2 | awk ' { print $10 } ' | sed 's:=: :g' | sed 's:": :g' | sed 's:&: :g' | awk ' { print $9 } '`
echo $ex2
ex3=`curl -v http://localhost:6666/mod_cluster_manager | grep CONTEXT | grep examples3 | awk ' { print $10 } ' | sed 's:=: :g' | sed 's:": :g' | sed 's:&: :g' | awk ' { print $9 } '`
echo $ex3

# The main loop...
while true
do
# stop the tomcats
for tc in `echo "tc1 tc2 tc3"`
do
  echo $tc
  $tc/bin/shutdown.sh
  rm -rf $tc/logs
  mkdir $tc/logs
done

#wait until the tomcats stop.
while true
do
  ntc=`curl -v http://localhost:6666/mod_cluster_manager | grep Node | wc -l`
  if [ $ntc -eq 0 ];
  then
    break
  fi
  sleep 1
done

for tc in `echo "tc1 tc2 tc3"`
do
  echo $tc
  $tc/bin/startup.sh
done

# wait for the 3 tomcats are ready.
while true
do
  ntc=`curl -v http://localhost:6666/mod_cluster_manager | grep "Status: OK" | wc -l`
  if [ $ntc -eq 3 ];
  then
    break
  fi
  sleep 1
done

curl -v --cookie JSESSIONID=1234.$ex1 http://localhost:8000/examples1/ | grep 404
if [ $? -eq 0 ]; then
  echo "failed on examples1"
  exit 1
fi
curl -v --cookie JSESSIONID=1234.$ex2 http://localhost:8000/examples2/ | grep 404
if [ $? -eq 0 ]; then
  echo "failed on examples2"
  exit 1
fi
curl -v --cookie JSESSIONID=1234.$ex3 http://localhost:8000/examples3/ | grep 404
if [ $? -eq 0 ]; then
  echo "failed on examples3"
  exit 1
fi
done
