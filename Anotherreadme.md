# Construct a ground truth

Using a Hokuyo UTM-30LX to construct a ground truth with help of Google's Cartographer.

## Set up Computing Environment

NUC is the computing device. To set it up, you need:

* Install Cartographer
* Modify it and add new files

### Install Cartographer

Ubuntu 14.04 (Trusty) or 16.04 (Xenial) is needed.

<pre><code># Install wstool and rosdep.
sudo apt-get update
sudo apt-get install -y python-wstool python-rosdep ninja-build

# Create a new workspace in 'catkin_ws'.
mkdir catkin_ws
cd catkin_ws
wstool init src

# Merge the cartographer_ros.rosinstall file and fetch code for dependencies.
wstool merge -t src https://raw.githubusercontent.com/googlecartographer/cartographer_ros/master/cartographer_ros.rosinstall
wstool update -t src

# Install deb dependencies.
# The command 'sudo rosdep init' will print an error if you have already
# executed it since installing ROS. This error can be ignored.
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

# Build and install.
catkin_make_isolated --install --use-ninja
source install_isolated/setup.bash
</code></pre>

#### Attention

Every change you have made to it, please re-build it using:

<pre><code>catkin_make_isolated --install --use-ninja
source install_isolated/setup.bash
</code></pre>

The command <code>wstool update -t src</code> may print an error when you cannot automatically download ceres-solver. Manually download it (verison 1.12.0, <https://github.com/ceres-solver/ceres-solver/releases/tag/1.12.0>) and put it in the folder <code>src</code>.

### Modify it and add new files

We modify one file and add a few.

Below is what we changed.

<pre><code>/home/apr/catkin_ws/src/cartographer_ros/cartographer_ros/cartographer_ros/assets_writer_main.cc</code></pre>

All files we added and their locations are listed in the documention *高精度激光雷达构建 ground truth*.

Merge your folder <code>/catkin\_ws/src/cartographer\_ros</code> with <code>APRG1\_ALGO/2dslam\_groundtruth</code>. Put the folder <code>ground\_truth</code> and <code>liuhuaiyu</code> in the right path as the documention has listed *高精度激光雷达构建 ground truth*.

## Run

### 1. Prepare LIDAR

1. Charge the battery.
2. Connect the LIDAR with the battery. Pay special attention to anode and cathode of the LIDAR. **Tags must have the same orientation**.
3. Connect the LIDAR with NUC (USB).

### 2. Run

1. Use any computer (Windows or Linux) to login the NUC. e.g. <pre><code>ssh apr@192.169.30.219
password: 123456</code></pre>
2. Open 3 terminal named A, B cand C, both login to it.
3. Input as follows:

<pre><code># start roscore
A: roscore # never make any change to A

# change directory
B & C: cd ~/ground_truth/command_line

# configure the LIDAR
B: bash configure_lidar.sh

B: bash scanning.sh

# the LIDAR is scanning now
# record LIDAR data (sensor_msgs/LaserScan) as ~/ground_truth/ground_truth_record.bag
C: bash record_data.sh

# move around. don't block the LIDAR

# when you finish recording, stop scanning and recording
B: Ctrl + C
C: Ctrl + C

# offline process lidar data to create .pbstream file
B: bash process_offline.sh 

# when it shows 'process has finished cleanly', usually 1/10 of the scanning duration
B: Ctrl + C

# get optimized trajectory data and pre-process it for Matlab use
B: bash process_offline_data.sh # wait for finishing

# shut down roscore
A: Ctrl + C

# congratulations on finally finishing the procedure! (LOL~)
</code></pre>

### 3. Download trajectory data

Use <code>scp</code> to copy <code>~/ground\_truth/tf\_offline\_processed.txt</code> to your local directory. e.g.

<pre><code>scp apr@192.169.30.219:~/ground_truth/tf_offline_processed.txt /Users/liuhuaiyu/Desktop/Ninebot
</code></pre>

## All Done!


## Contact

Huaiyu Liu

Ninebot Inc. APR Intern

liuhuaiyu14@mails.tsinghua.edu.cn







