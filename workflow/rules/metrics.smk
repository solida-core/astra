rule BedToIntervalList:
    input:
        bed=config.get('resources').get('regions')
    output:
        ilist=resolve_results_filepath('metrics', "regions.interval_list"),
    params:
        genome=config.get("resources").get("reference"),
    conda:
        resolve_envs_filepath("gatk.yaml")
    log:
        resolve_logs_filepath('metrics',"bed2IntervalList.log"),
    benchmark:
        resolve_benchmarks_filepath('metrics',"bed2IntervalList.txt"),
    threads: conservative_cpu_count(reserve_cores=2,max_cores=99)
    resources:
        tmpdir=temp_path(),
    shell:
        "gatk  BedToIntervalList "
        "--INPUT {input.bed} "
        "--SEQUENCE_DICTIONARY {params.genome} "
        "--OUTPUT {output.ilist} "

rule CollectHsMetrics:
    input:
        cram=rules.preprocessing.output.cram,
        crai=rules.preprocessing.output.crai,
        ilist=rules.BedToIntervalList.output.ilist,
    output:
        metrics=resolve_results_filepath('metrics', "{sample}.hsmetrics.dat"),
    conda:
        resolve_envs_filepath("gatk.yaml")
    log:
        resolve_logs_filepath('metrics',"CollectHsMetrics.log"),
    benchmark:
        resolve_benchmarks_filepath('metrics',"CollectHsMetrics.txt"),
    threads: conservative_cpu_count(reserve_cores=2,max_cores=99)
    resources:
        tmpdir=temp_path(),
    shell:
        "gatk CollectHsMetrics "
        "--BAIT_INTERVALS {input.ilist} "
        "--TARGET_INTERVALS {input.ilist} "
        "--INPUT {input.cram} "
        "--OUTPUT {output.metrics} "