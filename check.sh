ex1=`curl -v http://localhost:6666/mod_cluster_manager | grep CONTEXT | grep examples1 | awk ' { print $10 } ' | sed 's:=: :g' | sed 's:": :g' | sed 's:&: :g' | awk ' { print $9 } '`
echo $ex1
ex2=`curl -v http://localhost:6666/mod_cluster_manager | grep CONTEXT | grep examples2 | awk ' { print $10 } ' | sed 's:=: :g' | sed 's:": :g' | sed 's:&: :g' | awk ' { print $9 } '`
echo $ex2
ex3=`curl -v http://localhost:6666/mod_cluster_manager | grep CONTEXT | grep examples3 | awk ' { print $10 } ' | sed 's:=: :g' | sed 's:": :g' | sed 's:&: :g' | awk ' { print $9 } '`
echo $ex3

while true
do
curl -v --cookie JSESSIONID=1234.$ex1 http://localhost:8000/examples1/ | grep 404
if [ $? -eq 0 ]; then
  echo "failed example1"
  exit 1
fi
curl -v --cookie JSESSIONID=1234.$ex2 http://localhost:8000/examples2/ | grep 404
if [ $? -eq 0 ]; then
  echo "failed example2"
  exit 1
fi
curl -v --cookie JSESSIONID=1234.$ex3 http://localhost:8000/examples3/ | grep 404
if [ $? -eq 0 ]; then
  echo "failed example3"
  exit 1
fi
done
