# um_reddit
Example code for working with reddit data on the University of Michigan's Hadoop cluster.

## Audience
This code was drawn up to get myself going with the Reddit data on UM's resources. Since there isn't much documentation for beginners and this data is popular, I am sharing my code. It assumes you are at least a little familiar with python, pandas, and the linux or mac command line. 

## Tools
I'm writing most of those code in pyspark because it fits my particular needs and offers a dataframe setup that is similar to pandas and my other workflows. For compatability reasons, pyspark currently requires using python 2 on this cluster.

## Existing documentation
- UM's ARC-TS has some helpful but brief user guides online: 
	- http://arc-ts.umich.edu/systems-and-services/hadoop
	- http://arc-ts.umich.edu/new-hadoop-user-guide
	- http://arc-ts.umich.edu/hadoop-user-guide
- There are many helpful resources findable on google, but I find myself referring to this guide so much that it is worth sharing here:
	- https://www.analyticsvidhya.com/blog/2016/10/spark-dataframe-and-operations

## Getting set up
Working in the raw command line is a bare, so I set up jupyter notebooks. 
1. Use this command to connect to flux hadoop 
	- `ssh -L 8889:localhost:8889 flux-hadoop-login.arc-ts.umich.edu`
	- Change the port number, `8889` to something else. (If you run into errors, it may be that this port is already used. Pick another high number.)
	- This creates an ssh tunnel that forwards connections between your local computer and the flux hadoop computers. We'll use it to connect to our jupyter notebook there. 
2. Add these two lines to your `.bashrc` file **on flux hadoop**:
	- `export PYSPARK_DRIVER_PYTHON=jupyter`
	- `export PYSPARK_DRIVER_PYTHON_OPTS='notebook --no-browser --port=8889'`
		- Use the same port number here as in your ssh command.
	- These set it up such that whenever you launch `pyspark`, it automatically launches a jupyter notebook on that server.
3. Use a command like the one in `jup.sh` to launch pyspark. This lets you set higher JVM memory limits and specify how many executors should be used to run your jobs. Change the values as necessary.
4. When the notebook is running, it will give a link in the terminal. Copy that link and paste it into the browser on your desktop. ta-da, Jupyter notebooks!

## Working with the data



