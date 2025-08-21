#!/bin/bash

TARGET=$1


rm -f ${TARGET}/*.txt

while :
do
    cat /proc/vmstat | grep numa_pages_migrated >> ${TARGET}/numa_pages_migrated.txt
    cat /proc/vmstat | grep numa_hint_faults >> ${TARGET}/numa_hint_faults.txt
    cat /proc/vmstat | grep numa_hint_faults_local >> ${TARGET}/numa_hint_faults_local.txt
    cat /proc/vmstat | grep numa_pte_updates >> ${TARGET}/numa_pte_updates.txt
    cat /proc/vmstat | grep pgmigrate_su >> ${TARGET}/pgmig_suc.txt
    cat /proc/vmstat | grep pgmigrate_fail >> ${TARGET}/pgmig_fail.txt
    cat /proc/vmstat | grep thp_migration_success >> ${TARGET}/thp_pgmig_suc.txt
    cat /proc/vmstat | grep thp_migration_fail >> ${TARGET}/thp_pgmig_fail.txt
    cat /proc/vmstat | grep thp_migration_split >> ${TARGET}/thp_pgmig_split.txt
    cat /proc/vmstat | grep pgpromote_success >> ${TARGET}/pgpromote_success.txt
    cat /proc/vmstat | grep pgdemote_kswapd >> ${TARGET}/pgdemote_kswapd.txt
    cat /proc/vmstat | grep pgdemote_direct >> ${TARGET}/pgdemote_direct.txt
    cat /proc/vmstat | grep pgpromote_candidate >> ${TARGET}/pgpromote_candidate.txt
    cat /proc/vmstat | grep promote_threshold >> ${TARGET}/promote_threshold.txt
    cat /proc/vmstat | grep pgpromote_file >> ${TARGET}/pgpromote_file.txt
    cat /proc/vmstat | grep pgpromote_try >> ${TARGET}/pgpromote_try.txt
    cat /proc/vmstat | grep pgpromote_demoted >> ${TARGET}/pgpromote_demoted.txt

    # TPP
    cat /proc/vmstat | grep pgpromote_tried >> ${TARGET}/pgpromote_tried.txt
    cat /proc/vmstat | grep pgpromote_anon >> ${TARGET}/pgpromote_anon.txt
    cat /proc/vmstat | grep pgpromote_candidate_demoted >> ${TARGET}/pgpromote_candidate_demoted.txt
    cat /proc/vmstat | grep pgpromote_candidate_anon >> ${TARGET}/pgpromote_candidate_anon.txt
    cat /proc/vmstat | grep pgpromote_candidate_file >> ${TARGET}/pgpromote_candidate_file.txt

    # memtis
    # cat /sys/fs/cgroup/htmm/memory.stat | grep -e anon_thp -e anon >> ${TARGET}/memtis_memory_stat.txt
    # cat /sys/fs/cgroup/htmm/memory.hotness_stat >> ${TARGET}/memtis_hotness_stat.txt
    cat /proc/vmstat | grep htmm_nr_promoted >> ${TARGET}/htmm_nr_promoted.txt
    cat /proc/vmstat | grep htmm_nr_demoted >> ${TARGET}/htmm_nr_demoted.txt
    cat /proc/vmstat | grep htmm_nr_sampled >> ${TARGET}/htmm_nr_sampled.txt

    sleep 1
done