import numpy
import theano

v01 = theano.shared(numpy.random.random((10240, 10240)).astype('float32'),
                    target='dev0')
v02 = theano.shared(numpy.random.random((10240, 10240)).astype('float32'),
                    target='dev0')
v11 = theano.shared(numpy.random.random((10240, 10240)).astype('float32'),
                    target='dev1')
v12 = theano.shared(numpy.random.random((10240, 10240)).astype('float32'),
                    target='dev1')

f = theano.function([], [theano.tensor.dot(v01, v02),
                         theano.tensor.dot(v11, v12)])

f()
