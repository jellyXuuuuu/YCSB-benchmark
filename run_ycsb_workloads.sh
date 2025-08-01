#!/bin/bash

# 定义workload列表
WORKLOADS=("a" "b" "c" "d" "e")

# 数据库操作函数
function setup_database {
    echo "准备数据库..."
    mysql -u root -e "USE test; TRUNCATE TABLE usertable;"
}

# 执行YCSB测试
for workload in "${WORKLOADS[@]}"; do
    setup_database
    
    echo "开始加载workload${workload}数据..."
    bin/ycsb load jdbc -P "workloads/workload${workload}" -P jdbc-binding/conf/db.properties \
        -cp mysql-connector-java-8.0.33.jar \
        -s > "enterprise_load_${workload}.log"
    
    echo "开始运行workload${workload}测试..."
    bin/ycsb run jdbc -P "workloads/workload${workload}" -P jdbc-binding/conf/db.properties \
        -cp mysql-connector-java-8.0.33.jar \
        -s > "enterprise_run_${workload}.log"
    
    echo "workload${workload}测试完成!"
done

echo "所有workload测试已完成！"    