# Download the raw data
prefetch ERR13482692
fastq-dump split-files ERR13482692.fastq

# Quality control of data
fastqc ERR13482692_1.fastq ERR13482692_2.fastq fastqc_results/

# Adapter trimming and low quality reads filtering
fastp -i ERR13482692_1.fastq -o trimmed.fastq -I ERR13482692_2.fastq -O trimmed.fastq

# Alignment to Reference Genome
bwa index /home/abhi/ref/ref_genome.fa #indexing of reference genome
bwa mem -t 8 /home/abhi/ref/ref_genome.fa trimmed_1.fastq trimmed_2.fastq > align.bam # alignment
samtools flagstat align.sam # check quality of sam file
samtools view -bS align.sam # convert sam into bam
samtools sort -o sorted.bam # sorting
samtools index sorted.bam # indexing 

# Variant Calling
bcftools mpileup -Ou -f /home/abhi/ref/ref_genome.fa sorted.bam 
bcftools call -mv -Ob -o variants.vcf # call variants
bcftools indexing variants.vcf.gz # indexing
bcftools filter -e 'QUAL < 30 || DP < 15'  -o filtered_variants.vcf  variants.vcf.gz # filter low quality variants 
bcftools index filtered_variants.vcf.gz

# Variant annotation 
java -Xmx4g -jar snpEff.jar -v GRCh38.99 filtered_variants.vcf > snpeff_annotated_variants.vcf
