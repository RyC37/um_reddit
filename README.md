# um_reddit
Example code for working with reddit data on the University of Michigan's Flux Hadoop cluster.

## Audience
This code was drawn up to get myself going with the Reddit data on UM's resources. Since there isn't much documentation for beginners and this data is popular, I am sharing my code. It assumes you are at least a little familiar with python, pandas, and the linux or mac command line. It assumes no experience with spark, pyspark, HDFS, hadoop, etc.

## Tools
I'm writing most of those code in pyspark because it fits my particular needs and offers a dataframe setup that is similar to pandas and my other workflows. For compatability reasons, pyspark currently requires using python 2 on this cluster.

## Existing documentation
- UM's ARC-TS has some helpful but brief user guides online: 
	- http://arc-ts.umich.edu/systems-and-services/hadoop
	- http://arc-ts.umich.edu/new-hadoop-user-guide
- There are many helpful resources findable on google. THis one has been particularly helpful:
	- https://www.analyticsvidhya.com/blog/2016/10/spark-dataframe-and-operations

## Getting set up
Working in the raw command line is a pain, so I set up jupyter notebooks. 
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

## Getting data out
- The directories spark sees are all in HDFS: it has a whole separate file tree. Whatever you see there you won't see in your normal directories, even if they have the same name/path. 
- To get files out of HDFS into normal directories (e.g. to download the results saved by spark), use the `hdfs dfs --get [filename]` command. 
- Unfortunately, when spark saves a file to HDFS, it actually saves a directory filled with chunks of the file instead of a single file with everything put together. So `file.tsv` in HDFS is actually a directory full fo little tsv files, not a single fie with all your data. That's ideal for spark and hadoop, but a problem for more traditional tools. There are several options for dealing with this:
	- You can merge it into one file before saving it in spark, but that requires the file to be smaller than the Java memory on various parts of your spark cluster.
	- You can use the `hdfs dfs -getmerge [file.tsv]` command to merge all the parts into a single file when you pull them out of HDFS into your regular directories. This simply concatenates the files, so if they have a header there will be multiple header rows in the middle of the output file. By default, `spark.write.csv` does not include headers. 
	- You can write a small custom script to read and combine the parts in a smart way, like my example `combine_tsv.ipynb`. This allows saving files with headers. 
- The reddit data have basically no text validation. They contain many characters that can trip up analysis software, from newlines and carriage returns to dangling quotation marks. 
	- The `select_subreddits.ipynb` example removes the characters that are problematic for tsv files (`\r\n\t`) and adjusts the quoting parameters in the write.csv function of pyspark so that the resulting files can be read without error by `pandas.read_csv()`. 
		- N.B. If you encounter "unexpected EOF" errors, they're likely the result of quotes that have been escaped improperly. Those should be fixed already by this code.



