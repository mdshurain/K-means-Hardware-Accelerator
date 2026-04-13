FPGA-Based Parallel K-Means Clustering Accelerator

Files:
- distance_unit.v
- min2_with_id.v
- kmeans_top_3.v
- tb_kmeans_top_3.v
- centroid_update.v (optional)

Quartus flow:
1. New project
2. Add all .v files
3. Set kmeans_top_3 as top level
4. Compile
5. Simulate with tb_kmeans_top_3
6. Review resource and timing reports
