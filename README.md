# variant_calling of illuminna reads 

****variant calling** Variant calling is a bioinformatics process used to identify genetic variations, such as single nucleotide polymorphisms (SNPs) and insertions or deletions (indels), from sequencing data. It involves aligning raw DNA or RNA sequence reads to a reference genome, analyzing discrepancies between the reference and the sample, and determining the location, type, and frequency of these variations. This process is critical for studying genetic diversity, understanding disease mechanisms, and identifying potential therapeutic targets.

**data collection** 
- NCBI SRA and SRA Toolkit used to download raw sequencing data.
- https://github.com/ncbi/sra-tools/wiki/01.-Downloading-SRA-Toolkit

**Quality control of data** 
fastqc tool used to perfrom quality control of data. fastp tools used to trim and filter low quality data.
- https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
- https://github.com/OpenGene/fastp

**alignment to refrence genome**
- BWA tool used to alignment to reference genome. samtools are used to sorting and indexing. 
- https://github.com/lh3/bwa
- https://github.com/lh3/bwa
  
**variant calling**
- variant calling performed using Bcftools.
- https://samtools.github.io/bcftools/bcftools.html

**variant annotation**
- variant annotation was doen using snpEff, you can also used annover and vep.
- https://pcingola.github.io/SnpEff/snpeff/introduction/

