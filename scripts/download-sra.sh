#!/bin/bash


input=$(basename ${snakemake_input})
downloadsDir=$(dirname ${snakemake_output['dir']})


# mkdir -p ${snakemake_output['dir']}
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

echo ""


echo -e "snakemake_input is ${snakemake_input} \n"
echo -e "snakemake output is ${snakemake_output['dir']} \n"

echo $(dirname ${snakemake_output['dir']})

prefetch ${input} \
--output-directory ${downloadsDir} \
--progress \
--max-size u
pwd
ls

