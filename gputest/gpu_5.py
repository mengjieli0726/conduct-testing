#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the Licens

from __future__ import print_function
import sys,os

import numpy as np
from pyspark.sql import SparkSession


def gpurun(line):
    pwd1 = os.path.split(os.path.realpath(__file__))[0]
    #n=os.system('/opt/fxie/zoo54/spark-2.2.0-hadoop-2.7/examples/src/main/python/aa.sh')
    n=os.system(pwd1+'/aa.sh')

if __name__ == "__main__":


    spark = SparkSession\
        .builder\
        .appName("GPUAPP")\
        .getOrCreate()
    
    data = [1,2,3,4,5]
    distData = spark.sparkContext.parallelize(data,5)
    num = distData.count()
    print ('====================**==============================='+str(num))
    
    print ('====================**end==============================='+str(num))
    
    data = distData.map(gpurun)
    output = data.collect()

    spark.stop()
