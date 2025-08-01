#!/bin/bash

# 定义workload列表
WORKLOADS=("a" "b" "c" "d" "e" "f")
ROOT1='/mnt/test_ssd/ycsb-rocksdb-data'
ROOT2='/mnt/test_ssd_1602/ycsb-rocksdb-data'

# 执行YCSB测试
for workload in "${WORKLOADS[@]}"; do
  
    # echo "开始加载workload${workload}数据..."
    # bin/ycsb load rocksdb -P "workloads/workload${workload}" \
    #     -p rocksdb.dir=${ROOT1} \
    #     -s > "rslt_load_${workload}-flux.log"
    
    echo "flux 开始运行workload${workload}测试..."
    bin/ycsb run rocksdb -P "workloads/workload${workload}" \
        -p rocksdb.dir=${ROOT1} \
        -s > "rslt_run_${workload}-flux.log"

    #  echo "开始加载workload${workload}数据..."
    # bin/ycsb load rocksdb -P "workloads/workload${workload}" \
    #     -p rocksdb.dir=${ROOT2} \
    #     -s > "rslt_load_${workload}-1602.log"
    
    echo "1602 开始运行workload${workload}测试..."
    bin/ycsb run rocksdb -P "workloads/workload${workload}" \
        -p rocksdb.dir=${ROOT2} \
        -s > "rslt_run_${workload}-1602.log"
    
    
    echo "workload${workload}测试完成!"
done

echo "所有workload测试已完成！"    