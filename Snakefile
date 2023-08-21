from os.path import join

# from snakemake.remote.GS import RemoteProvider as GSRemoteProvider
# GS = GSRemoteProvider()
# GS_PREFIX = "ncbi-ccle-data/SRA"

SRAlist = ['SRR8615081', 'SRR8615087']

sra_docker = "docker://jjjermiah/sra-tools:0.1"
gcloud_docker = "docker://google/cloud-sdk:slim"



# final = GS.remote( GS_PREFIX + "/processed/SRR8615081", keep_local=True)
rule all:
    input:
        # expand("input/{sra}.txt", sra=SRAlist),
        # expand("downloads/{sra}/", sra=SRAlist)
        expand("processed/{sra}", sra=SRAlist)
        # dir=GS.remote(expand("ncbi-ccle-data/test/{sra}", sra=SRAlist))

rule download_SRA:
    input:
        "input/{sra}"
    output:
        # a file with the same name as the input file, but in the downloads directory
        dir=directory("downloads/{sra}")
    threads: 
        1
    container:
        sra_docker
    script:
        "scripts/download-sra.sh"

rule process_SRA:
    input:
        "downloads/{sra}"
    output:
        dir=directory("processed/{sra}")
    threads: 2
    container:
        sra_docker
    script:
        "scripts/process-sra.sh"

# rule upload_GCS:
#     input:
#         downloadDir="downloads/{sra}",
#         processedDir="processed/{sra}"
#     output:
#         dir=GS.remote("ncbi-ccle-data/test/{sra}/")
#     # container:
#     #     gcloud_docker
#     script:
#         "scripts/upload-gcs.sh"


rule generate_input_files:
    output:
       expand("input/{sra}", sra=SRAlist)
    shell:
        "touch {output}; echo "
    

rule clean:
    shell:
        "rm -rf ncbi-ccle-data input/* downloads/* processed/*; gsutil -m rm -r gs://ncbi-ccle-data/*"