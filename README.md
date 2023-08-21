


packages:
pip3 install kubernetes
snakemake
singularity
google-cloud-storageDREA
``` bash

snakemake -c7 \
    --default-remote-provider GS \
    --default-remote-prefix ncbi-ccle-data/SRA \
    --use-singularity
```


``` bash
export CLUSTER_NAME="snakemake-cluster-big"
export ZONE="northamerica-northeast2"
export NODES=2
export DISK_SIZE="20GB"
export MAX_NODES=10
gcloud container clusters create \
    $CLUSTER_NAME \
     --zone=$ZONE \
    --num-nodes=$NODES \
    --machine-type="n1-standard-8" \
    --scopes storage-rw \
    --image-type="UBUNTU_CONTAINERD" \
    --disk-size=$DISK_SIZE \
    --enable-autoscaling \
    --max-nodes=$MAX_NODES \
    --min-nodes=0
gcloud container clusters get-credentials $CLUSTER_NAME


```

``` bash
snakemake \
    -j 16 \
    --keep-remote \
    --kubernetes \
    --default-remote-provider GS \
    --default-remote-prefix ncbi-ccle-data/SRA \
    --use-singularity 



```