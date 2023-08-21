
adcfile=${snakemake_input['ADCfile']}
downloadDir=${snakemake_input['downloadDir']}
processedDir=${snakemake_input['processedDir']}
gcsBucket=${snakemake_output}
echo ${downloadDir}
echo ${processedDir}
echo ${adcfile}
echo ${snakemake_output}
echo ""


gsutil cp -r ${downloadDir} gs://${gcsBucket}
gsutil cp README.md gs://ncbi-ccle-data

