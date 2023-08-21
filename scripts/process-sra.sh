#!/bin/bash


# Temporary fix for the cache problems. 
vdb-config --set /repository/remote/disabled="false"
vdb-config --set /repository/remote/main/CGI/resolver-cgi="https://trace.ncbi.nlm.nih.gov/Traces/names/names.fcgi"
vdb-config --set /repository/remote/main/SDL.2/resolver-cgi="https://locate.ncbi.nlm.nih.gov/sdl/2/retrieve"
vdb-config --set /repository/remote/protected/CGI/resolver-cgi="https://trace.ncbi.nlm.nih.gov/Traces/names/names.fcgi"
vdb-config --set /repository/remote/protected/SDL.2/resolver-cgi="https://locate.ncbi.nlm.nih.gov/sdl/2/retrieve"
vdb-config --set /repository/user/main/public/root=downloadsDir
vdb-config --set /repository/user/ad/public/apps/file/volumes/flatAd=downloadsDir
vdb-config --set /repository/user/ad/public/apps/refseq/volumes/refseqAd=downloadsDir
vdb-config --set /repository/user/ad/public/apps/sra/volumes/sraAd=downloadsDir
vdb-config --set /repository/user/ad/public/apps/sraPileup/volumes/ad=downloadsDir
vdb-config --set /repository/user/ad/public/apps/sraRealign/volumes/ad=downloadsDir
vdb-config --set /repository/user/ad/public/apps/wgs/volumes/wgsAd=downloadsDir
vdb-config --set /repository/user/ad/public/root=downloadsDir


echo ${snakemake_input}
echo ${snakemake[threads]}

downloadsDir=$(dirname ${snakemake_output['dir']})
fastqDir=${snakemake_output['dir']}
echo ${downloadsDir}
mkdir -p ${fastqDir}

# Run fasterq dump 
fasterq-dump --outdir ${fastqDir} \
--temp ${downloadsDir} \
--threads ${snakemake[threads]} \
${snakemake_input}


# docker build --build-arg CLOUD_SDK_VERSION=443.0.0 \
#     --build-arg INSTALL_COMPONENTS="gsutil" \
#     -t gcloud_gsutil:slim .