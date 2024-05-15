## R script for annotating Ensembl genes
rm(list=ls())

## Requires biomaRt
require(biomaRt)


## Input
file.counts <- "/Users/olga/Documents/NBIS/!PROJECTS/3270_lithium/!Documentation/Results/tableCounts.txt"
file.save <- "/Users/olga/Documents/NBIS/!PROJECTS/3270_lithium/!Documentation/Results/tableCounts_annotations.txt"

## Use Ensembl mouse dataset
#ensembl = useMart("ensembl")
#listDatasets(ensembl)
# as the main Ensembl portal is currently unavailable, one needs to specify alternative portal e.g. jul2015.archive.ensembl.org
ensemble.mart=useMart(biomart="ENSEMBL_MART_ENSEMBL", dataset="rnorvegicus_gene_ensembl")#, host = "jul2015.archive.ensembl.org")

## available attributes available (uncomment below)
head(listAttributes(ensemble.mart))
## save attritubutes to the file
write.table(listAttributes(ensemble.mart), file='listAttributes.txt', sep='\t', quote=F, row.names=F, col.names=F)

## Genes to annotate
table.counts <- read.delim(file.counts)
my.genes <- as.character(rownames(table.counts))

## Retrieving data frame for the selected attributes
my.attributes <- c("ensembl_gene_id", "ensembl_transcript_id", "entrezgene", "chromosome_name", "start_position",  "end_position", "external_gene_name", "description")      
ensemble.df <- getBM(attributes=my.attributes, mart=ensemble.mart)

## Annotating a set of genes
my.annotation = ensemble.df[match(my.genes, ensemble.df$ensembl_gene_id),]
head(my.annotation)

## Saving annotation file
write.table(my.annotation, file.save, sep='\t', quote=F, row.names=F)

sessionInfo()

