# um_reddit
Example code for working with reddit data on the University of Michigan's Hadoop cluster.

## Audience
This code was drawn up to get myself going with the Reddit data on UM's resources. Since there isn't much documentation for beginners and this data is popular, I am sharing my code. It assumes you are at least a little familiar with python, pandas, and the linux or mac command line. 

## Getting setup
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
3. Use a command like the one in `jup.sh` to launch pyspark. This lets you set higher JVM memory limits and specify how many executors should be used to run your jobs. Change the values as necessary
4. When the notebook is running, it will give a link in the terminal. Copy that link and paste it into the browser on your desktop. ta-da, Jupyter notebooks!

## Working with the data



