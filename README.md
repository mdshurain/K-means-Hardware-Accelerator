# K-means-Hardware-Accelerator
Implemented a parallel hardware accelerator for K-Means clustering in Verilog, incorporating distance computation and cluster assignment within a GPU-inspired architecture.
What is K-Means Clustering?
K-Means is an unsupervised machine learning algorithm used to group data into K clusters based on similarity.

Algorithm Steps:
Initialize K centroids

For each data point:

Compute distance to all centroids
Assign to nearest centroid
Update centroids (mean of assigned points)

Repeat until convergence

Project Objective
The goal of this project is to design a hardware accelerator for the most computationally intensive step of K-Means:

Distance computation and cluster assignment

Instead of sequential execution (CPU-style), this design performs computations in parallel, significantly improving performance.

Architecture
The design consists of the following modules:

1. Distance Unit
Computes squared Euclidean distance: (x - cx)^2 + (y - cy)^2
Avoids square root for hardware efficiency
2. Parallel Distance Computation
Multiple distance units operate simultaneously
Each unit corresponds to one centroid
3. Comparator Tree
Compares distances to find the minimum
Requires K-1 comparisons
4. Index Tracking
Each distance is tagged with a cluster ID
Comparator propagates the correct cluster index
Why This is GPU-Inspired
The design mimics GPU-style parallelism:

Same operation applied to multiple data inputs
Multiple compute units working simultaneously
Data-level parallelism (SIMD-like behavior)
Simulation
Simulation is performed using ModelSim.

Basic flow:

Compile Verilog modules
Run testbench (tb_kmeans_top_3.v)
Observe waveform and cluster assignment output
Tools Used
Verilog (RTL Design)
Intel Quartus Prime (Synthesis)
ModelSim (Simulation)
Current Status
Parallel distance computation implemented
Comparator tree for cluster selection
Centroid update unit (in progress)
FPGA synthesis and optimization (in progress)
Future Work
Implement centroid update (mean calculation)
Add pipelining for higher throughput
Extend to higher dimensions
Optimize area and power
Key Learning Outcomes
Hardware mapping of machine learning algorithms
Parallel architecture design
RTL design using Verilog
FPGA-based prototyping
Note
This project is a work in progress and is being actively developed to explore hardware acceleration techniques for machine learning algorithms.

Author
Mohammed Shurain
