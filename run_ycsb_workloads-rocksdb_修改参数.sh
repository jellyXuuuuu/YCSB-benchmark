#!/bin/bash

# 定义workload列表
WORKLOADS=("a" "b" "c" "d" "f")
ROOT1='/mnt/test_ssd/ycsb-rocksdb-data'
ROOT2='/mnt/test_ssd_1602/ycsb-rocksdb-data'

# 执行YCSB测试
for workload in "${WORKLOADS[@]}"; do
  

    echo "[flux] 开始运行workload${workload}测试..."
    bin/ycsb run rocksdb -P "workloads/workload${workload}" \
        -p recordcount=20000000 \
        -p operationcount=20000000 \
        -p threadcount=160 \
        -p keygenerator=com.yahoo.ycsb.generator.FixedLengthStringGenerator:16 \
        -p rocksdb.prop="block_cache_size=268435456;cache_index_and_filter_blocks=true" \
        -p zipfian.constant=0.99 \
        -p fieldlength=64 \
        -p rocksdb.dir=${ROOT1} \
        -s > "100millions_${workload}-flux.log"

  
    echo ""
    echo "[1602] 开始运行workload${workload}测试..."
    bin/ycsb run rocksdb -P "workloads/workload${workload}" \
        -p recordcount=20000000 \
        -p operationcount=20000000 \
        -p threadcount=160 \
        -p keygenerator=com.yahoo.ycsb.generator.FixedLengthStringGenerator:16 \
        -p rocksdb.prop="block_cache_size=268435456;cache_index_and_filter_blocks=true" \
        -p zipfian.constant=0.99 \
        -p fieldlength=64 \
        -p rocksdb.dir=${ROOT2} \
        -s > "100millions_${workload}-1602.log"
    
    
    echo "workload${workload}测试完成!"
done

echo "所有workload测试已完成！"    