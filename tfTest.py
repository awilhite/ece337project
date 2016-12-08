import input_data
import tensorflow as tf
import numpy as np
mnist = input_data.read_data_sets('MNIST_data', one_hot=True)

sess = tf.InteractiveSession()

x = tf.placeholder("float", shape=[None,784])
y_ = tf.placeholder("float", shape=[None,10])
W = tf.Variable(tf.zeros([784,10]))

sess.run(tf.initialize_all_variables())

y = tf.nn.softmax(tf.matmul(x,W))

cross_entropy = -tf.reduce_sum(y_*tf.log(y))


trainstep = tf.train.GradientDescentOptimizer(0.01).minimize(cross_entropy)

for i in range(1000):
	batch = mnist.train.next_batch(50)
	trainstep.run(feed_dict={x: batch[0], y_: batch[1]})

correct_predict = tf.equal(tf.argmax(y,1), tf.argmax(y_,1))
acc = tf.reduce_mean(tf.cast(correct_predict, "float"))

weights = W.eval()
weights = weights * 100000
np.savetxt("matrix.txt",weights,"%10.10f")
print(mnist.test.labels[50])
np.savetxt("image.txt", mnist.test.images[50].reshape((28,28))*255,'%d')