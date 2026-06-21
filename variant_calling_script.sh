#!/bin/bash

SAMPLE="ERR13482692"
REF="/home/abhi/ref/ref_genome.fa"

prefetch $SAMPLE

fasterq-dump $SAMPLE --split-files

fastqc ${SAMPLE}_1.fastq ${SAMPLE}_2.fastq -o fastqc_results

fastp -i ${SAMPLE}_1.fastq -I ${SAMPLE}_2.fastq -o ${SAMPLE}_trimmed_1.fastq -O ${SAMPLE}_trimmed_2.fastq

bwa index $REF

bwa mem -t 8 $REF ${SAMPLE}_trimmed_1.fastq ${SAMPLE}_trimmed_2.fastq > ${SAMPLE}.sam

samtools flagstat ${SAMPLE}.sam > ${SAMPLE}_flagstat.txt

samtools view -bS ${SAMPLE}.sam > ${SAMPLE}.bam

samtools sort ${SAMPLE}.bam -o ${SAMPLE}_sorted.bam

samtools index ${SAMPLE}_sorted.bam

bcftools mpileup -Ou -f $REF ${SAMPLE}_sorted.bam | bcftools call -mv -Oz -o ${SAMPLE}_variants.vcf.gz

bcftools index ${SAMPLE}_variants.vcf.gz

bcftools filter -e 'QUAL<30 || DP<15' ${SAMPLE}_variants.vcf.gz -Oz -o ${SAMPLE}_filtered.vcf.gz

bcftools index ${SAMPLE}_filtered.vcf.gz

java -Xmx4g -jar snpEff.jar GRCh38.99 ${SAMPLE}_filtered.vcf.gz > ${SAMPLE}_annotated.vcf
