#!/usr/bin/env bash
#echo "hello word!">/opt/fxie/777.txt
export MKL_THREADING_LAYER=GNU
#function rand(){    
#    min=$1    
#    max=$(($2-$min+1))    
#    num=$(date +%s%N)    
#    echo $(($num%$max+$min))    
#}  
#rnd=$(rand 0 3) 
export THEANO_FLAGS=mode=FAST_RUN,device=cuda,floatX=float32
#export THEANO_FLAGS="contexts=dev0->cuda0;dev1->cuda1" 
#/root/anaconda3/bin/python3.6 /opt/fxie/gputest/gpu3.py

#/opt/anaconda2/bin/python2.7   /home/yuanrxa/gputest/gpu3.py
#/opt/anaconda2/bin/python2.7 /home/alzhi/gputest/gpu3.py
/opt/anaconda2/bin/python2.7 /scratch/qa1/lingxu/gputest/gpu3.py
#/opt/anaconda3/bin/python3.7  /scratch/qa1/lingxu/gputest/test.py
